import 'dart:async';
import 'dart:convert' as conv;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:safe/models/media_server/start_recording_response.model.dart';
import 'package:safe/models/media_server/stop_recording_response.model.dart';

enum TokenRole { publisher, subscriber }

enum MediaAction {
  getResourceID,
  startRecording,
  stopRecording,
  getRTCToken,
  process,
}

enum TokenType { uid, userAccount }

class MediaServer {
  static const Map<MediaAction, String> actionMap = {
    MediaAction.getRTCToken: "rtc",
    MediaAction.getResourceID: "rid",
    MediaAction.process: "process",
    MediaAction.startRecording: "start",
    MediaAction.stopRecording: "stop",
  };

  String _encodeBase64(String raw) {
    final bytes = conv.utf8.encode(raw);
    final base64Str = conv.base64.encode(bytes);

    return base64Str;
  }

  String generateChannelName(String id) =>
      _encodeBase64(id).replaceAll(RegExp("[^A-Za-z0-9]"), "");

  String generateDirectory(String userId) {
    String noSym = userId.replaceAll(RegExp("[^A-Za-z0-9]"), "");

    if (!(noSym.length >= 125)) {
      return noSym;
    }

    return noSym.substring(0, noSym.length - (noSym.length - 125).abs());
  }

  /// Stops cloud recording in a livestreaming session
  String _genCredentials(Map<String, String> env) => _encodeBase64(
        "${env["MEDIA_KEY"]}:${env["MEDIA_SECRET"]}",
      );

  /// Handle "network jitter". Reference code 65 in Agora docs for more information https://docs.agora.io/en/cloud-recording/reference/common-errors#:~:text=65%3A%20Usually%20caused%20by%20network%20jitter.
  Future<Map?> _handleNetworkJitter(
    Map<String, dynamic> body,
    MediaAction action,
    int timeFactr,
    Function(String e) onError,
  ) async {
    // Increases from 3 to 9 (ie, 3, 6, 9)
    await Future.delayed(Duration(
      seconds: 3 * timeFactr,
    ));
    return _fetch(action, body, onError);
  }

  Future<StopRecordingResponse?> stopRecording({
    required String channelName,
    required int recordingId,
    required String resourceId,
    required String incidentId,
    required String collection,
    required String sid,
    required Function(String e) onError,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    Map<String, String> body = {
      "appId": env["AGORA_APP_ID"]!,
      "customerKey": env["AGORA_CUSTOMER_KEY"]!,
      "customerSecret": env["AGORA_CUSTOMER_SECRET"]!,
      "recordingId": recordingId.toString(),
      "sid": sid,
      "incidentId": incidentId,
      "collection": collection,
      "bucketId": env["BUCKET_ID"]!,
      "resourceId": resourceId,
      "channelName": channelName,
    };

    var json = await _fetch(
      MediaAction.stopRecording,
      body,
      onError,
    );

    if (json == null) return null;

    if (json["error"] != null) {
      Map? res = await _implementHandleNetworkJitter(
        body,
        MediaAction.stopRecording,
        json,
        onError,
      );

      if (res == null) return null;

      return StopRecordingResponse.fromJson(json["payload"]["response"]);
    }

    return StopRecordingResponse.fromJson(json["payload"]["response"]);
  }

  /// Fetches ID required for cloud recording
  Future<String?> getResourceID({
    required String channelName,
    required int recordingId,
    required Function(String e) onError,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    Map<String, String> body = {
      "appId": env["AGORA_APP_ID"]!,
      "customerKey": env["AGORA_CUSTOMER_KEY"]!,
      "customerSecret": env["AGORA_CUSTOMER_SECRET"]!,
      "recordingId": recordingId.toString(),
      "channelName": channelName,
    };

    var json = await _fetch(
      MediaAction.getResourceID,
      body,
      onError,
    );

    if (json == null) return null;

    if (json["error"] != null) {
      Map? res = await _implementHandleNetworkJitter(
        body,
        MediaAction.getResourceID,
        json,
        onError,
      );

      if (res == null) return null;

      return json["payload"]["resource_id"];
    }

    return json["payload"]["resource_id"];
  }

  /// Takes recording options and begins recording a livestreaming session
  Future<StartRecordingResponse?> startRecording({
    required String dir1,
    required String dir2,
    required String userUid,
    required String channelName,
    required int recordingId,
    required String resourceId,
    required int maxIdleTime,
    required String token,
    required Function(String e) onError,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    Map<String, dynamic> body = {
      "appId": env["AGORA_APP_ID"]!,
      "customerKey": env["AGORA_CUSTOMER_KEY"]!,
      "customerSecret": env["AGORA_CUSTOMER_SECRET"]!,
      "recordingId": recordingId.toString(),
      "resourceId": resourceId,
      "channelName": channelName,
      "token": token,
      "maxIdleTime": maxIdleTime.toString(),
      "uid": userUid,
      "storage": {
        "bucketAccessKey": env["BUCKET_ACCESS_KEY"]!,
        "bucketId": env["BUCKET_ID"]!,
        "bucketSecretKey": env["BUCKET_SECRET_KEY"]!,
        "dir1": dir1,
        "dir2": dir2,
      }
    };

    var json = await _fetch(
      MediaAction.startRecording,
      body,
      onError,
    );

    if (json == null) return null;

    if (json["error"] != null) {
      Map? res = await _implementHandleNetworkJitter(
        body,
        MediaAction.startRecording,
        json,
        onError,
      );

      if (res == null) return null;

      return StartRecordingResponse.fromJson(json["payload"]);
    }

    return StartRecordingResponse.fromJson(json["payload"]);
  }

  Future<Map?> _implementHandleNetworkJitter(
    Map<String, dynamic> body,
    MediaAction action,
    Map? response,
    Function(String e) onError,
  ) async {
    bool check65Exists = false;

    try {
      check65Exists = (response?["error"]["response"] as String).contains(
        ":65,",
      );
    } catch (e) {
      print(e);
    }

    if (!check65Exists) return null;

    bool shouldStop = false;
    int jitterRetries = 0;
    Map? json;

    // Give network chance to respond
    while (!shouldStop) {
      jitterRetries++;

      // Fetch
      json = await _handleNetworkJitter(
        body,
        action,
        jitterRetries,
        onError,
      );

      if (json?["status"] == 200) {
        shouldStop = true;
      }

      // Determine if should continue
      bool retriesUsed = jitterRetries == 2;
      bool isJsonNull = json == null;
      bool isError65 = true;

      try {
        isError65 = (json?["error"]["response"] as String).contains(":65,");
      } catch (e) {
        print(e);
      }

      shouldStop = retriesUsed || isJsonNull || !isError65;
    }

    if (json?["status"] != 200) return null;

    return json;
  }

  /// Generates token used to start a livestream & recording session
  Future<String?> generateRTCToken({
    required String channelName,
    required TokenRole role,
    required TokenType type,
    required int uid,
    required Function(String e) onError,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    Map<String, String> body = {
      "uid": uid.toString(),
      "appId": env["AGORA_APP_ID"]!,
      "appCertificate": env["AGORA_CERT"]!,
      "role": unpackTokenRole(role),
      "tokenType": unpackTokenType(type),
      "channelName": channelName,
    };

    //Make Request
    var json = await _fetch(
      MediaAction.getRTCToken,
      body,
      onError,
    );

    if (json == null) return null;

    if (json["error"] != null) {
      Map? res = await _implementHandleNetworkJitter(
        body,
        MediaAction.getRTCToken,
        json,
        onError,
      );

      if (res == null) return null;

      return json["payload"]["token"];
    }

    return json["payload"]["token"];
  }

  Future<Map?> _fetch(MediaAction action, Map<String, dynamic> body,
      Function(String e) onError) async {
    http.Response? response;

    // Get URL parameters
    Map<String, String> env = dotenv.env;

    String target = actionMap[action]!;

    String endpoint =
        "${env["MEDIA_ENDPOINT"]!}/$target?key=${_genCredentials(env)}";

    try {
      response =
          await http.post(Uri.parse(endpoint), body: conv.json.encode(body));
    } catch (e) {
      onError(e.toString());
    }

    if (response == null) return null;

    Map<String, dynamic> json = conv.jsonDecode(response.body);

    if (response.statusCode != 200) {
      var res = {
        "status": response.statusCode,
        "error": json,
      };

      onError(res.toString());

      return res;
    }

    return {
      "status": response.statusCode,
      "error": null,
      "payload": json,
    };
  }

  String unpackTokenType(TokenType type) {
    String raw = type.toString();
    return raw.substring(10, raw.length);
  }

  String unpackTokenRole(TokenRole role) {
    String raw = role.toString();
    return raw.substring(10, raw.length);
  }
}
