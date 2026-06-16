import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../services/profile_storage_service.dart';

import 'package:flutter/material.dart';

import '../models/profile_model.dart';
import '../services/profile_storage_service.dart';

class ProfileProvider extends ChangeNotifier {

  ProfileModel profile = ProfileModel(
    name: "Guest User",
    bio: "Add your bio",
    imagePath: null,
  );

  ProfileProvider() {
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data =
        await ProfileStorageService.loadProfile();

    profile.name = data['name'];
    profile.bio = data['bio'];
    profile.imagePath = data['imagePath'];

    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String bio,
  }) async {

    profile.name = name;
    profile.bio = bio;

    await ProfileStorageService.saveProfile(
      profile.name,
      profile.bio,
      profile.imagePath,
    );

    notifyListeners();
  }

  Future<void> updatePhoto(String path) async {

    profile.imagePath = path;

    await ProfileStorageService.saveProfile(
      profile.name,
      profile.bio,
      profile.imagePath,
    );

    notifyListeners();
  }

  Future<void> removePhoto() async {

    profile.imagePath = null;

    await ProfileStorageService.saveProfile(
      profile.name,
      profile.bio,
      null,
    );

    notifyListeners();
  }
}