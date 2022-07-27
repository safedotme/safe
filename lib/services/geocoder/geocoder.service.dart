import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GeocoderService {
  static const String endpoint =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng={LAT},{LONG}&key={KEY}";

  Future<Map<String, dynamic>?> fetchAddress({
    required double lat,
    required double long,
  }) async {
    String key = dotenv.env['GOOGLE_MAPS_KEY']!;
    String loaded = endpoint
        .replaceAll("{KEY}", key)
        .replaceAll("{LAT}", lat.toString())
        .replaceAll("{LONG}", long.toString());

    var response = await http.get(Uri.parse(loaded));

    if (response.body.isEmpty) {
      return null;
    }

    return jsonDecode(response.body);
  }
}
