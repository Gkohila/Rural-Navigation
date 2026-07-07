import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  static const String apiKey = "AIzaSyCfhDygEEJHiTagRgmrt_QPM1FJUjVZ9Us";

  static Future<Map<String, double>?> getCoordinates(String place) async {
    print("Searching Place = $place");

    final url =
        "https://maps.googleapis.com/maps/api/geocode/json"
        "?address=${Uri.encodeComponent(place)}"
        "&key=$apiKey";

    print(url);

    final response = await http.get(Uri.parse(url));

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    if (response.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(response.body);

    print("Google Status = ${data["status"]}");

    if (data["status"] != "OK") {
      print("Google Error = ${data["error_message"]}");
      return null;
    }

    final location = data["results"][0]["geometry"]["location"];

    return {
      "lat": (location["lat"] as num).toDouble(),
      "lng": (location["lng"] as num).toDouble(),
    };
  }
}