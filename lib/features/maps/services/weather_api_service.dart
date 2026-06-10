import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';
import 'package:flutter/foundation.dart';

class WeatherApiService {

  static Future<WeatherModel?> getWeather(
    double lat,
    double lon,
    String language,
  ) async {

    try {

      final baseUrl = kIsWeb
    ? 'http://localhost:8081'
    : 'http://10.0.2.2:8081';

final url =
    '$baseUrl/api/weather/current'
    '?lat=$lat'
    '&lon=$lon'
    '&lang=$language';

      print("API URL = $url");

      final response =
          await http.get(Uri.parse(url));

      print("STATUS CODE = ${response.statusCode}");
      print("RESPONSE = ${response.body}");

      if (response.statusCode != 200) {
        return null;
      }

      final data =
          jsonDecode(response.body);

      print("PARSED DATA = $data");

      return WeatherModel(
        location:
            data['location'] ?? '',

        temperature:
            (data['temperature'] ?? 0)
                .toDouble(),

        weather:
            data['weather'] ?? '',

        time:
            data['time'] ?? '',
      );

    } catch (e) {

      print(
        'Weather API Error: $e',
      );

      return null;
    }
  }
}