import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

enum TokenRole { publisher }

enum TokenType { uid, userAccount }

class TokenServer {
  Future<String?> generate({
    required String channelName,
    required TokenRole role,
    required TokenType type,
    required String uid,
  }) async {
    // Get URL parameters
    Map<String, String> env = dotenv.env;

    // URL endpoint
    String template =
        "{endpoint}/rtc/{channel_name}/{role}/{type}/{uid}/{app_id}/{app_certificate}/";

    String loaded = template
        .replaceAll("{endpoint}", env["TOKEN_ENDPOINT"]!)
        .replaceAll("{channel_name}", channelName)
        .replaceAll("{role}", unpackTokenRole(role))
        .replaceAll("{type}", unpackTokenType(type))
        .replaceAll("{uid}", uid)
        .replaceAll("{app_id}", env["AGORA_APP_ID"]!)
        .replaceAll("{app_certificate}", env["AGORA_CERT"]!);

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
