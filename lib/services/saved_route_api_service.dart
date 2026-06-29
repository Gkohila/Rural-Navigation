import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/saved_route_model.dart';

class SavedRouteApiService {
  static String get baseUrl =>
      kIsWeb ? "http://localhost:8081" : "http://10.0.2.2:8081";

  /// SAVE ROUTE
  static Future<bool> saveRoute(
    SavedRouteModel route,
  ) async {
    // Check already saved
    bool alreadySaved =
        await isRouteSaved(route.vehicleNumber);

    if (alreadySaved) {
      return false;
    }

    final response = await http.post(
      Uri.parse("$baseUrl/api/saved-routes"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(route.toJson()),
    );

    return response.statusCode == 200 ||
        response.statusCode == 201;
  }

  /// GET SAVED ROUTES
  static Future<List<SavedRouteModel>>
      getSavedRoutes() async {
    final prefs =
        await SharedPreferences.getInstance();

    final userId = prefs.getInt("userId");

    print("USER ID FROM PREF = $userId");

    if (userId == null) {
      return [];
    }

    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/saved-routes/$userId",
      ),
    );

    if (response.statusCode != 200) {
      return [];
    }

    final List data =
        jsonDecode(response.body);

    return data
        .map(
          (e) => SavedRouteModel.fromJson(e),
        )
        .toList();
  }

  /// CHECK ROUTE ALREADY SAVED
  static Future<bool> isRouteSaved(
    String vehicleNumber,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    final userId =
        prefs.getInt("userId");

    if (userId == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/saved-routes/exists?userId=$userId&vehicleNumber=$vehicleNumber",
      ),
    );

    if (response.statusCode == 200) {
      return response.body == "true";
    }

    return false;
  }

  /// DELETE ROUTE
  static Future<bool> deleteRoute(
    int id,
  ) async {
    final response = await http.delete(
      Uri.parse(
        "$baseUrl/api/saved-routes/$id",
      ),
    );

    return response.statusCode == 200 ||
        response.statusCode == 201;
  }
    /// DELETE ALL ROUTES OF USER
  static Future<bool> deleteAllRoutes() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("userId");

    if (userId == null) {
      return false;
    }

    final response = await http.delete(
      Uri.parse(
        "$baseUrl/api/saved-routes/user/$userId",
      ),
    );

    return response.statusCode == 200 ||
        response.statusCode == 204;
  }
}