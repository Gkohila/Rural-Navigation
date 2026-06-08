import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherApiService {

  static Future<WeatherModel?> getWeather(
    double lat,
    double lon,
    String language,
  ) async {

    try {

      final url =
          'https://api.openweathermap.org/data/2.5/weather'
          '?lat=$lat'
          '&lon=$lon'
          '&appid=5fa30522f6eb281b2347ac033a9c8311'
          '&units=metric'
          '&lang=$language';

      final response =
          await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        return null;
      }

      final data =
          jsonDecode(response.body);

      final now = DateTime.now();

      return WeatherModel(
        location: data['name'] ?? '',
        temperature:
            (data['main']['temp'] ?? 0).toDouble(),
        weather:
            data['weather'][0]['description'] ?? '',
        time:
            '${now.hour}:${now.minute}',
      );

    } catch (e) {

      print('Weather Error: $e');
      return null;

    }
  }
}