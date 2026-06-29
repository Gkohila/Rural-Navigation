import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/route_progress_model.dart';

class RouteProgressService {

  static const String baseUrl =
      "http://localhost:8081/api/progress";

  Future<RouteProgressModel>
      getProgress(
          String vehicleNumber) async {

    final response = await http.get(

      Uri.parse(
        "$baseUrl/$vehicleNumber",
      ),
    );

    if (response.statusCode == 200) {

      return RouteProgressModel.fromJson(

        jsonDecode(
          response.body,
        ),

      );
    }

    throw Exception(
      "Unable to fetch route progress",
    );
  }
}