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
  timeout,
}

class AnalyticsService {
  final String endpoint = "https://api.logsnag.com/v1/";

  static const Map<ErrorLogType, String> mapErrors = {
    ErrorLogType.rtcFailed: "rtc-failed",
    ErrorLogType.mediaServerFailed: "media-server-failed",
    ErrorLogType.twilioFailed: "twilio-failed",
    ErrorLogType.geocoderFailed: "geocoder-failed",
  };

  Future<Response> log(AnalyticsLog log) {
    var env = dotenv.env;
    return post(
      Uri.parse("${endpoint}log"),
      headers: {
        "Authorization": "Bearer ${env["LOG_SNAG_TOKEN"]}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(log.toMap()),
    );
  }

  Future<Response> insight(AnalyticsInsight insight) async {
    var env = dotenv.env;
    return patch(
      Uri.parse("${endpoint}insight"),
      headers: {
        "Authorization": "Bearer ${env["LOG_SNAG_TOKEN"]}",
        "Content-Type": "application/json",
      },
      body: jsonEncode(insight.toMap()),
    );
  }
}
