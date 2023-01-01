import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:safe/services/analytics/helper_classes/analytics_request_model.service.dart';

class AnalyticsService {
  final String endpoint = "https://api.logsnag.com/v1/log";

  Future<Response> request(AnalyticsRequest request) async {
    var env = DotEnv().env;
    return post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${env["LOG_SNAG_TOKEN"]}"
      },
      body: request.toMap(),
    );
  }
}
