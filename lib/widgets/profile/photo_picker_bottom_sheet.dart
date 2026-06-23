import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';
import '../../providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '../../screens/profile/camera_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/profile_api_service.dart';


class PhotoPickerBottomSheet extends StatefulWidget {
  const PhotoPickerBottomSheet({super.key});

  @override
  State<PhotoPickerBottomSheet> createState() =>
      _PhotoPickerBottomSheetState();
}

class _PhotoPickerBottomSheetState
    extends State<PhotoPickerBottomSheet> {

  final ImagePicker picker = ImagePicker();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  Uint8List? selectedImage;

 @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final profileProvider =
        Provider.of<ProfileProvider>(
          context,
          listen: false,
        );

    if (profileProvider.profile.name != "Guest User") {
      nameController.text =
          profileProvider.profile.name;
    }

    if (profileProvider.profile.bio != "Add your bio") {
      bioController.text =
          profileProvider.profile.bio;
    }
    selectedImage =
    profileProvider.profile.imageBytes;
  });
}

  @override
  Widget build(BuildContext context) {
    final languageProvider =
    Provider.of<LanguageProvider>(context);

final localizations =
    AppLocalizations(
      languageProvider.languageCode,
    );
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 8,
        sigmaY: 8,
      ),

      child: Container(
        color: Colors.black.withOpacity(0.15),

        child: Align(
          alignment: Alignment.bottomCenter,

          child: Container(
            width: double.infinity,

            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              18,
            ),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.97),

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 25,
                  offset: const Offset(0, -6),
                ),
              ],
            ),

            child: SafeArea(
              top: false,

              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    /// HANDLE
                    Container(
                      width: 65,
                      height: 6,

                      decoration: BoxDecoration(
                        color: const Color(0xFFD8D8D8),

                        borderRadius:
                            BorderRadius.circular(100),
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// TITLE
                    Align(
                      alignment: Alignment.centerLeft,

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
  localizations.text('editProfile'),
  style: GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF0B5D1E),
  ),
),

                          const SizedBox(height: 6),

                          Text(
  localizations.text('updateProfileInfo'),
  style: GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.black54,
  ),
),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                   TextField(
  controller: nameController,
  decoration: InputDecoration(
    labelText: localizations.text('name'),
    hintText: "Enter your name",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
),

const SizedBox(height: 16),

TextField(
  controller: bioController,
  maxLines: 2,
  maxLength: 60,
  decoration: InputDecoration(
    labelText: localizations.text('about'),
    hintText: "Tell us about yourself",
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
),

const SizedBox(height: 24),

                    /// CAMERA
GestureDetector(
  onTap: () async {

    final imageBytes = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const CameraScreen(),
  ),
);

if (imageBytes != null) {

  setState(() {
    selectedImage = imageBytes;
  });

  
}
  },

  child: _optionTile(
    icon: Icons.camera_alt_outlined,
    title: localizations.text('takePhoto'),
    iconBg: const Color(0xFFE8F7EA),
    iconColor: const Color(0xFF0B5D1E),
  ),
),

                    const SizedBox(height: 14),

                    /// GALLERY
                    GestureDetector(
  onTap: () async {

    await pickImage();

  },

  child: _optionTile(
  icon: Icons.image_outlined,
  title: selectedImage == null
      ? localizations.text('chooseGallery')
      : "Photo Selected ✓",
  iconBg: const Color(0xFFEAF2FF),
  iconColor: const Color(0xFF1565C0),
),
),

                    const SizedBox(height: 14),


/// REMOVE PHOTO
GestureDetector(
  onTap: () async {

    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Remove Photo"),
          content: const Text(
            "Delete profile photo?",
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text("Remove"),
            ),
          ],
        );
      },
    );

  if (confirm == true) {

  setState(() {
    selectedImage = null;
  });

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Photo Removed"),
    ),
  );
}
  },

  child: Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),

    decoration: BoxDecoration(
      color: const Color(0xFFFFF4F4),
      borderRadius:
          BorderRadius.circular(24),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),

    child: Row(
      children: [

        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFFFFE2E2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 28,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Text(
            localizations.text(
              'removeCurrentPhoto',
            ),
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),

        const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.redAccent,
        ),
      ],
    ),
  ),
),

const SizedBox(height: 20),

Row(
  children: [

    Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          localizations.text('cancel'),
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),

    const SizedBox(width: 12),

    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(0, 58),
          backgroundColor: const Color(0xFF0B5D1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {

  final prefs =
      await SharedPreferences.getInstance();

  final mobile =
      prefs.getString("mobile");

  if (mobile == null) {
    return;
  }

  String imageString = "";

if (selectedImage != null) {
  imageString =
      base64Encode(selectedImage!);
}

await ProfileApiService.updateProfile(
  mobile: mobile,
  name: nameController.text.trim(),
  bio: bioController.text.trim(),
  profileImage: imageString,
);


  final profileProvider =
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      );

await profileProvider.updateProfile(
  name: nameController.text.trim(),
  bio: bioController.text.trim(),
);

if (selectedImage != null) {
  await profileProvider.updatePhoto(
    selectedImage!,
  );
}

ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: const Color(0xFF0A5B1D),
    behavior: SnackBarBehavior.floating,
    content: const Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Text(
          "Profile Updated Successfully",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
);

Navigator.pop(context);
},
        child: Text(
          localizations.text('save'),
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),

  ],
),

                   const SizedBox(height: 8),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _optionTile({
    required IconData icon,
    required String title,
    required Color iconBg,
    required Color iconColor,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.03),

            blurRadius: 12,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,

              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }

Future<void> pickImage() async {

  print("PICK IMAGE CLICKED");

  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (image == null) {
    print("NO IMAGE SELECTED");
    return;
  }

  print("IMAGE SELECTED");

  final bytes = await image.readAsBytes();

  setState(() {
    selectedImage = bytes;
  });

  
}

  @override
void dispose() {
  nameController.dispose();
  bioController.dispose();
  super.dispose();
}
}