import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class ProfileApiService {

  static String get baseUrl =>
      kIsWeb
          ? "http://localhost:8081"
          : "http://10.0.2.2:8081";

  static Future<Map<String, dynamic>?> getProfile(
      String mobile) async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl/api/users/mobile/$mobile",
      ),
    );

    if (response.statusCode == 200 &&
        response.body.isNotEmpty) {

      return jsonDecode(response.body);
    }

    return null;
  }

  static Future<bool> updateProfile({
    required String mobile,
    required String name,
    required String bio,
    String? profileImage,
  }) async {

    final response = await http.put(
      Uri.parse(
        "$baseUrl/api/users/profile/$mobile",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "bio": bio,
        "profileImage": profileImage,
      }),
    );

    return response.statusCode == 200;
  }
}