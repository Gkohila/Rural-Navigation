import 'dart:convert';
import 'package:http/http.dart' as http;


class GeocodingService { 
  static const String apiKey = "AIzaSyCfhDygEEJHiTagRgmrt_QPM1FJUjVZ9Us";

  static Future<Map<String, double>?> getCoordinates(
      String place) async {

    final url =
        "https://maps.googleapis.com/maps/api/geocode/json"
        "?address=${Uri.encodeComponent(place)}"
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["results"] != null &&
          data["results"].isNotEmpty) {

        final location =
            data["results"][0]["geometry"]["location"];

        return {
          "lat": (location["lat"] as num).toDouble(),
          "lng": (location["lng"] as num).toDouble(),
        };
      }
    }

    return null;
  }
}