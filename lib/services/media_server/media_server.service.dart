import 'dart:async';
import 'dart:convert';

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
}

enum TokenType { uid, userAccount }

class MediaServer {
  String _encodeBase64(String raw) {
    final bytes = utf8.encode(raw);
    final base64Str = base64.encode(bytes);

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

  Future<StopRecordingResponse?> stopRecording({
    required String channelName,
    required int recordingId,
    required String resourceId,
    required String sid,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/stop/{channel_name}/{customer_key}/{customer_secret}/{app_id}/{recording_id}/{sid}/{resource_id}/{cred}/";

    String loaded = template
        .replaceAll("{channel_name}", _encodeBase64(channelName))
        .replaceAll("{customer_key}", _encodeBase64(env["AGORA_CUSTOMER_KEY"]!))
        .replaceAll(
          "{customer_secret}",
          _encodeBase64(env["AGORA_CUSTOMER_SECRET"]!),
        )
        .replaceAll("{app_id}", _encodeBase64(env["AGORA_APP_ID"]!))
        .replaceAll("{recording_id}", _encodeBase64(recordingId.toString()))
        .replaceAll("{sid}", _encodeBase64(sid))
        .replaceAll("{resource_id}", _encodeBase64(resourceId))
        .replaceAll(
          "{cred}",
          _genCredentials(env),
        )
        .replaceAll(
          "{endpoint}",
          env["MEDIA_ENDPOINT"]!,
        );

    print(sid);

    var json = await _fetch(loaded, MediaAction.stopRecording);

    if (json == null) return null;

    return StopRecordingResponse.fromJson(json);
  }

  /// Fetches ID required for cloud recording
  Future<String?> getResourceID({
    required String channelName,
    required int recordingId,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rid/{channel_name}/{customer_key}/{customer_secret}/{app_id}/{recording_id}/{cred}/";

    String loaded = template
        .replaceAll("{endpoint}", env["MEDIA_ENDPOINT"]!)
        .replaceAll("{channel_name}", _encodeBase64(channelName))
        .replaceAll("{customer_key}", _encodeBase64(env["AGORA_CUSTOMER_KEY"]!))
        .replaceAll(
          "{customer_secret}",
          _encodeBase64(env["AGORA_CUSTOMER_SECRET"]!),
        )
        .replaceAll("{app_id}", _encodeBase64(env["AGORA_APP_ID"]!))
        .replaceAll("{recording_id}", _encodeBase64(recordingId.toString()))
        .replaceAll(
          "{cred}",
          _genCredentials(env),
        );

    var json = await _fetch(loaded, MediaAction.getResourceID);

    if (json == null) return null;

    return json["resource_id"];
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
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String bucketInfo =
        "{bucket_id}/{bucket_access_key}/{bucket_secret_key}/{user_uid}/{dir1}/{dir2}";

    String basicInfo =
        "{app_id}/{channel_name}/{recording_id}/{resource_id}/{customer_key}/{customer_secret}/{token}";

    String recordingInfo = "{max_idle_time}";

    String template =
        "{endpoint}/start/{basic_info}/{recording_info}/{bucket_info}/{cred}/";

    // Replace with encoded values
    bucketInfo = bucketInfo
        .replaceAll(
          "{bucket_id}",
          _encodeBase64(env["BUCKET_ID"]!),
        )
        .replaceAll(
          "{bucket_access_key}",
          _encodeBase64(env["BUCKET_ACCESS_KEY"]!),
        )
        .replaceAll(
          "{bucket_secret_key}",
          _encodeBase64(env["BUCKET_SECRET_KEY"]!),
        )
        .replaceAll("{user_uid}", _encodeBase64(userUid))
        .replaceAll("{dir1}", _encodeBase64(dir1))
        .replaceAll("{dir2}", _encodeBase64(dir2));

    basicInfo = basicInfo
        .replaceAll("{app_id}", _encodeBase64(env["AGORA_APP_ID"]!))
        .replaceAll("{channel_name}", _encodeBase64(channelName))
        .replaceAll("{recording_id}", _encodeBase64(recordingId.toString()))
        .replaceAll("{resource_id}", _encodeBase64(resourceId))
        .replaceAll(
          "{customer_key}",
          _encodeBase64(env["AGORA_CUSTOMER_KEY"]!),
        )
        .replaceAll(
          "{customer_secret}",
          _encodeBase64(env["AGORA_CUSTOMER_SECRET"]!),
        )
        .replaceAll("{token}", _encodeBase64(token));

    recordingInfo = recordingInfo.replaceAll(
      "{max_idle_time}",
      _encodeBase64(maxIdleTime.toString()),
    );

    // Generate template
    String loaded = template
        .replaceAll("{basic_info}", basicInfo)
        .replaceAll("{recording_info}", recordingInfo)
        .replaceAll("{bucket_info}", bucketInfo)
        .replaceAll("{endpoint}", env["MEDIA_ENDPOINT"]!)
        .replaceAll("{cred}", _genCredentials(env));

    print(loaded);

    var json = await _fetch(loaded, MediaAction.startRecording);

    if (json == null) return null;

    return StartRecordingResponse.fromJson(json);
  }

  /// Generates token used to start a livestream & recording session
  Future<String?> generateRTCToken({
    required String channelName,
    required TokenRole role,
    required TokenType type,
    required int uid,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rtc/{channel_name}/{role}/{type}/{uid}/{app_id}/{app_certificate}/{credential}/";

    String loaded = template
        .replaceAll("{endpoint}", env["MEDIA_ENDPOINT"]!)
        .replaceAll("{channel_name}", _encodeBase64(channelName))
        .replaceAll("{role}", _encodeBase64(unpackTokenRole(role)))
        .replaceAll("{type}", _encodeBase64(unpackTokenType(type)))
        .replaceAll("{uid}", _encodeBase64(uid.toString()))
        .replaceAll("{app_id}", _encodeBase64(env["AGORA_APP_ID"]!))
        .replaceAll("{app_certificate}", _encodeBase64(env["AGORA_CERT"]!))
        .replaceAll("{credential}", _genCredentials(env));

    //Make Request
    var json = await _fetch(loaded, MediaAction.getRTCToken);

    print(json);

    if (json == null) return null;

    return json["rtcToken"];
  }

  Future<Map?> _fetch(String url, MediaAction action) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print(url);
      print(
          "RESPONSE: \n\tSTATUS: ${response.statusCode}\n\tBODY: ${response.body}");

      // TODO: handle error (LOG)
      return null;
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    return json;
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
