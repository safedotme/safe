import 'package:flutter_dotenv/flutter_dotenv.dart';

enum TokenRole { publisher }

enum TokenType { uid, userAccount }

class TokenServer {
  final String _endpoint = DotEnv().env["TOKEN_ENDPOINT"]!;

  // rtc/:channelName/:role/:tokentype/:uid/:id/:cert/

  Future<String> generate({
    required String channelName,
    required TokenRole role,
    required TokenType type,
    required int uid,
  }) async {
    // Generate URL endpoint
    Map<String, String> env = DotEnv().env;
    String template =
        "${_endpoint}rtc/$channelName/:role/:tokentype/$uid/${env["AGORA_APP_ID"]!}/${env["AGORA_CERT"]!}/";

    return "";
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
