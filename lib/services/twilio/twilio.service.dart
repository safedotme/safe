import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'package:safe/utils/text/text.util.dart';

class TwilioService {
  static const String endpoint = "https://api.twilio.com";
  static const String version = "2010-04-01";

  Uri _generateUri({required String sid, required String type}) {
    return Uri.parse(
      "$endpoint/$version/Accounts/$sid/$type.json",
    );
  }

  String _selectPhoneNumber(
    List<Map<String, int>> tally,
    void Function(List<Map<String, int>>) setTally,
  ) {
    Map<String, int> champ = tally[math.Random().nextInt(tally.length)];

    for (final entry in tally) {
      if (entry.values.first < champ.values.first) {
        champ = entry;
      }
    }

    tally.remove(champ);
    champ[champ.keys.first] = champ.values.first + 1;
    tally.add(champ);

    setTally(tally);

    return champ.keys.first;
  }

  Future<Map?> call({
    required String phone,
    required String message,
    required List<Map<String, int>> tally,
    required void Function(List<Map<String, int>>) setTally,
  }) async {
    final body = {
      "To": phone,
      "From": dotenv.env[_selectPhoneNumber(tally, setTally)],
      "Twiml": "<Response><Say>$message</Say></Response>",
    };

    final response = await _request(body, "Calls");

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>?> messageSMS({
    required String phone,
    required String message,
    required List<Map<String, int>> tally,
    required void Function(List<Map<String, int>>) setTally,
  }) async {
    final body = {
      "To": phone,
      "From": dotenv.env[_selectPhoneNumber(tally, setTally)],
      "Body": TextUtil.removeNonUSCChars(message),
    };

    final response = await _request(body, "Messages");

    return jsonDecode(response.body);
  }

  Future<http.Response> _request(Map body, String type) async {
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
      _generateUri(sid: dotenv.env["TWILIO_SID"]!, type: type),
      headers: headers,
      body: body,
    );
  }
}
