import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class IssueApiService {

  static String get baseUrl {

    if (kIsWeb) {
      return 'http://localhost:8081';
    }

    return 'http://10.0.2.2:8081';
  }

  static Future<bool> submitIssue({
    required String issueTitle,
    required String category,
    required String description,
  }) async {

    try {

      final response = await http.post(
        Uri.parse(
          '$baseUrl/api/issues/report',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'issueTitle': issueTitle,
          'category': category,
          'description': description,
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