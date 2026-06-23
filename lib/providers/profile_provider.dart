import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';
import '../services/profile_api_service.dart';

class ProfileProvider extends ChangeNotifier {

  ProfileModel profile = ProfileModel(
    name: "Guest User",
    bio: "Add your bio",
  );

  ProfileProvider() {
    loadProfile();
  }

  Future<void> loadProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    final mobile =
        prefs.getString("mobile");

    if (mobile == null) {
      return;
    }

    final data =
        await ProfileApiService.getProfile(
      mobile,
    );

    if (data == null) {
      return;
    }

    profile.name =
        data['name'] ?? "Guest User";

    profile.bio =
        data['bio'] ?? "Add your bio";

    if (data['profileImage'] != null &&
        data['profileImage']
            .toString()
            .isNotEmpty) {

      profile.imageBytes =
          base64Decode(
        data['profileImage'],
      );
    }

    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String bio,
  }) async {

    profile.name = name;
    profile.bio = bio;

    notifyListeners();
  }

  Future<void> updatePhoto(
    Uint8List bytes,
  ) async {

    profile.imageBytes = bytes;

    final prefs =
        await SharedPreferences.getInstance();

    final mobile =
        prefs.getString("mobile");

    if (mobile != null) {

      await ProfileApiService.updateProfile(
        mobile: mobile,
        name: profile.name,
        bio: profile.bio,
        profileImage:
            base64Encode(bytes),
      );
    }

    notifyListeners();
  }

  Future<void> removePhoto() async {

    profile.imageBytes = null;

    final prefs =
        await SharedPreferences.getInstance();

    final mobile =
        prefs.getString("mobile");

    if (mobile != null) {

      await ProfileApiService.updateProfile(
        mobile: mobile,
        name: profile.name,
        bio: profile.bio,
        profileImage: "",
      );
    }

    notifyListeners();
  }
}