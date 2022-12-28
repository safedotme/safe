import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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

  Future<void> startRecording() async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rtc/{channel_name}/{role}/{type}/{uid}/{app_id}/{app_certificate}/";
  }

  Future<void> _getResourceID() async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}rid/{channel_name}/{customer_key}/{customer_secret}/{app_id}/{recording_id}/:cred/";
  }

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
    http.Response response = await http.get(Uri.parse(loaded));

    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode != 200) {
      // TODO: handle error (LOG)
      return null;
    }

    return json["rtcToken"];
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
