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

    http.Response? response;

    try {
      response = await http.get(Uri.parse(loaded));
    } catch (e) {
      // (LOG) Not able to connect to GEOCODER
    }

    if (response == null) return null;

    Map<String, dynamic> json = jsonDecode(response.body);

    if (json["status"] != "OK") {
      return null;
    }

    return json;
  }
}
