import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/alert_model.dart';

class AlertService {

  static const String baseUrl =
      "http://localhost:8081/api/alerts";

  Future<List<AlertModel>> getAlerts(
      String vehicleNumber) async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl/$vehicleNumber",
      ),
    );

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

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

    final response = await http.get(
      Uri.parse(
        "$baseUrl/$vehicleNumber/unread-count",
      ),
    );

    if (response.statusCode == 200) {

      return int.parse(
        response.body,
      );
    }

    return 0;
  }

  Future<void> markAsRead(
      int id) async {

    await http.put(
      Uri.parse(
        "$baseUrl/$id/read",
      ),
    );
  }
}