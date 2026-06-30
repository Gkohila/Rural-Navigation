import 'dart:typed_data';

class ProfileModel {
  String name;
  String bio;
  Uint8List? imageBytes;

  ProfileModel({
    required this.name,
    required this.bio,
    this.imageBytes,
  });
}