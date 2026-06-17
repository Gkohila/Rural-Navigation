class ProfileModel {
  String name;
  String bio;
  String? imagePath;

  ProfileModel({
    required this.name,
    required this.bio,
    this.imagePath,
  });
}