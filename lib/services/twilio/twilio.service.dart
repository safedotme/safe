import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TwilioService {
  static const String endpoint = "https://api.twilio.com";
  static const String version = "2010-04-01";

  Uri _generateUri({required String sid}) {
    return Uri.parse(
      "$endpoint/$version/Accounts/$sid/Messages.json",
    );
  }

  Future<Map<String, dynamic>?> messageSMS({
    required String phone,
    required String message,
  }) async {
    // Generates headers in propper format
    var bytes = utf8.encode(
      "${dotenv.env["TWILIO_SID"]}:${dotenv.env["TWILIO_TOKEN"]}",
    );
    var base64String = base64.encode(bytes);

    // Generates header values in map
    var headers = {
      "Authorization": "Basic $base64String",
      "Accept": "application/json"
    };

    // Generates body values to be sent
    var body = {
      "From": dotenv.env["TWILIO_PHONE"],
      "To": phone,
      "Body": message,
    };

    var response = await http.post(
      _generateUri(sid: dotenv.env["TWILIO_SID"]!),
      headers: headers,
      body: body,
    );

    return jsonDecode(response.body);
  }
}
