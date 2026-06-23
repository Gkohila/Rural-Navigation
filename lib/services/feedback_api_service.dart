import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FeedbackApiService {

  static String get baseUrl {

    if (kIsWeb) {
      return 'http://localhost:8081';
    }

    return 'http://10.0.2.2:8081';
  }

  static Future<bool> submitFeedback({
    required String category,
    required String feedback,
  }) async {

    try {

      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/feedback/submit',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'category': category,
          'feedback': feedback,
        }),
      );

      print("STATUS = ${response.statusCode}");
      print("BODY = ${response.body}");

      return response.statusCode == 200;

    } catch (e) {

      print("ERROR = $e");
      return false;
    }
  }
}