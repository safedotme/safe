import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:safe/utils/text/text.util.dart';

class TwilioService {
  static const String endpoint = "https://api.twilio.com";
  static const String version = "2010-04-01";

  Uri _generateUri({required String sid}) {
    return Uri.parse(
      "$endpoint/$version/Accounts/$sid/Messages.json", //TODO: Change messages.json for calls
    );
  }

  Future<Map?> call({
    required String phone,
    required String message,
  }) async {
    final body = {
      "To": phone,
      "From": dotenv.env["TWILIO_PHONE"],
      "Twiml": message,
    };
  }

  Future<Map<String, dynamic>?> messageSMS({
    required String phone,
    required String message,
  }) async {
    // Generates body values to be sent
    final body = {
      "From": dotenv.env["TWILIO_PHONE"],
      "To": phone,
      "Body": TextUtil.removeNonUSCChars(message),
    };

    final response = await _request(body);

    return jsonDecode(response.body);
  }

  Future<http.Response> _request(Map body) async {
    // Generates headers in propper format
    final bytes = utf8.encode(
      "${dotenv.env["TWILIO_SID"]}:${dotenv.env["TWILIO_TOKEN"]}",
    );
    final base64String = base64.encode(bytes);

    // Generates header values in map
    final headers = {
      "Authorization": "Basic $base64String",
      "Accept": "application/json"
    };

    return http.post(
      _generateUri(sid: dotenv.env["TWILIO_SID"]!),
      headers: headers,
      body: body,
    );
  }
}
