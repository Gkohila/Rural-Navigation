import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorageService {

  static Future<void> saveProfile(
    String name,
    String bio,
    Uint8List? imageBytes,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      'profile_name',
      name,
    );

    await prefs.setString(
      'profile_bio',
      bio,
    );

    if (imageBytes != null) {

      final base64Image =
          base64Encode(imageBytes);

      await prefs.setString(
        'profile_image',
        base64Image,
      );
    }
  }

  static Future<Map<String, dynamic>>
      loadProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    Uint8List? imageBytes;

    final imageString =
        prefs.getString(
      'profile_image',
    );

    if (imageString != null) {
      imageBytes =
          base64Decode(imageString);
    }

    return {

      'name':
          prefs.getString(
                'profile_name',
              ) ??
              'Guest User',

      'bio':
          prefs.getString(
                'profile_bio',
              ) ??
              'Add your bio',

      'imageBytes': imageBytes,
    };
  }
}