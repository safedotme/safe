import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:safe/models/media_server/start_recording_response.model.dart';

enum TokenRole { publisher }

enum TokenType { uid, userAccount }

class MediaServer {
  String _encodeBase64(String raw) {
    final bytes = utf8.encode(raw);
    final base64Str = base64.encode(bytes);

    return base64Str;
  }

  String _genCredentials(Map<String, String> env) => _encodeBase64(
        "${env["MEDIA_KEY"]}:${env["MEDIA_SECRET"]}",
      );

  Future<void> stopRecording() async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rtc/{channel_name}/{role}/{type}/{uid}/{app_id}/{app_certificate}/";
  }

  Future<void> getResourceID() async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}rid/{channel_name}/{customer_key}/{customer_secret}/{app_id}/{recording_id}/:cred/";
  }

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
        "{endpoint}/start/$basicInfo/$recordingInfo/$bucketInfo/{cred}/";

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
          _encodeBase64(env["BCUKET_SECRET_KEY"]!),
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
          "{resource_id}",
          _encodeBase64(env["AGORA_CUSTOMER_SECRET"]!),
        )
        .replaceAll("{token}", _encodeBase64(token));

    recordingInfo = resourceId.replaceAll(
        "{max_idle_time}", _encodeBase64(maxIdleTime.toString()));

    String loaded = template
        .replaceAll("{endpoint}", env["MEDIA_ENDPOINT"]!)
        .replaceAll("{cred}", _genCredentials(env));

    var json = await fetch(loaded);

    if (json == null) return null;

    return StartRecordingResponse.fromJson(json);
  }

  /// Generates token used to start a livestream & recording session
  Future<String?> generateRTCToken({
    required String channelName,
    required TokenRole role,
    required TokenType type,
    required String uid,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rtc/{channel_name}/{role}/{type}/{uid}/{app_id}/{app_certificate}/{credential}";

    String loaded = template
        .replaceAll("{endpoint}", env["MEDIA_ENDPOINT"]!)
        .replaceAll("{channel_name}", _encodeBase64(channelName))
        .replaceAll("{role}", _encodeBase64(unpackTokenRole(role)))
        .replaceAll("{type}", _encodeBase64(unpackTokenType(type)))
        .replaceAll("{uid}", _encodeBase64(uid))
        .replaceAll("{app_id}", _encodeBase64(env["AGORA_APP_ID"]!))
        .replaceAll("{app_certificate}", _encodeBase64(env["AGORA_CERT"]!))
        .replaceAll("{credential}", _genCredentials(env));

    // Make Request
    var json = await fetch(loaded);

    if (json == null) return null;

    return json["rtcToken"];
  }

  Future<Map?> fetch(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      // TODO: handle error (LOG)
      return null;
    }

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
