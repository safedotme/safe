import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:safe/services/analytics/helper_classes/analytics_insight.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'dart:convert';

class AnalyticsService {
  final String endpoint = "https://api.logsnag.com/v1/";

  Future<void> log(AnalyticsLog log) async {
    var res = await _request(log.toMap(), "log");

    print(res.body);
  }

  Future<void> insight(AnalyticsInsight insight) =>
      _request(insight.toMap(), "insight");

  Future<Response> _request(Map body, String type) async {
    var env = dotenv.env;
    return post(
      Uri.parse(endpoint + type),
      headers: {
        "Authorization": "Bearer ${env["LOG_SNAG_TOKEN"]}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }
}
