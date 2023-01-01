import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:safe/services/analytics/helper_classes/analytics_insight.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';

class AnalyticsService {
  final String endpoint = "https://api.logsnag.com/v1/log";

  Future<void> log(AnalyticsLog log) => _request(log.toMap());

  Future<void> insight(AnalyticsInsight insight) => _request(insight.toMap());

  Future<Response> _request(Map body) async {
    var env = DotEnv().env;
    return post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${env["LOG_SNAG_TOKEN"]}"
      },
      body: body,
    );
  }
}
