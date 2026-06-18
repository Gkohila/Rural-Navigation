import 'package:shared_preferences/shared_preferences.dart';

class ProfileStorageService {
  static Future<void> saveProfile(
    String name,
    String bio,
    String? imagePath,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('profile_name', name);
    await prefs.setString('profile_bio', bio);

    if (imagePath != null) {
      await prefs.setString(
        'profile_image',
        imagePath,
      );
    }
  }

  static Future<Map<String, dynamic>> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      'name':
          prefs.getString('profile_name') ??
          'Guest User',

      'bio':
          prefs.getString('profile_bio') ??
          'Add your bio',

      'imagePath':
          prefs.getString('profile_image'),
    };
  }
}