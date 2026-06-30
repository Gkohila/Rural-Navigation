import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/alert_model.dart';

class AlertService {

  static const String baseUrl =
      "http://localhost:8081/api/alerts";

  Future<List<AlertModel>> getAlerts(
      String vehicleNumber) async {

    final uri = Uri.parse(
      "$baseUrl/${Uri.encodeComponent(vehicleNumber)}",
    );

    print("REQUEST URL = $uri");

    final response = await http.get(uri);

    print("STATUS = ${response.statusCode}");
    print("BODY = ${response.body}");

    if (response.statusCode == 200) {

      final List<dynamic> data =
          jsonDecode(response.body);

      print("TOTAL ALERTS = ${data.length}");

      return data
          .map(
            (e) => AlertModel.fromJson(e),
          )
          .toList();
    }

    return [];
  }

  Future<int> getUnreadCount(
      String vehicleNumber) async {

    final uri = Uri.parse(
      "$baseUrl/${Uri.encodeComponent(vehicleNumber)}/unread-count",
    );

    final response = await http.get(uri);

    print("UNREAD STATUS = ${response.statusCode}");
    print("UNREAD BODY = ${response.body}");

    if (response.statusCode == 200) {
      return int.parse(response.body);
    }

    return 0;
  }

  Future<void> markAsRead(
      int id) async {

    await http.put(
      Uri.parse("$baseUrl/$id/read"),
    );
  }

 Future<void> deleteAllAlerts(String vehicleNumber) async {
  final uri = Uri.parse(
    "$baseUrl/${Uri.encodeComponent(vehicleNumber)}",
  );

  print("DELETE URL: $uri");

  final response = await http.delete(uri);

  print("DELETE STATUS: ${response.statusCode}");
  print("DELETE BODY: ${response.body}");

  if (response.statusCode != 200) {
    throw Exception(
      "Delete failed: ${response.statusCode} ${response.body}",
    );
  }
}
}