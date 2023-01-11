import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:safe/services/analytics/helper_classes/analytics_insight.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'dart:convert';

enum ErrorLogType {
  rtcFailed,
  mediaServerFailed,
  twilioFailed,
  geocoderFailed,
}

class AnalyticsService {
  final String endpoint = "https://api.logsnag.com/v1/";

  static const Map<ErrorLogType, String> mapErrors = {
    ErrorLogType.rtcFailed: "rtc-failed",
    ErrorLogType.mediaServerFailed: "media-server-failed",
    ErrorLogType.twilioFailed: "twilio-failed",
    ErrorLogType.geocoderFailed: "geocoder-failed",
  };

  Future<void> log(AnalyticsLog log) => _request(log.toMap(), "log");

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
