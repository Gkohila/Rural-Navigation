import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoPickerBottomSheet extends StatefulWidget {
  const PhotoPickerBottomSheet({super.key});

  @override
  State<PhotoPickerBottomSheet> createState() =>
      _PhotoPickerBottomSheetState();
}

class _PhotoPickerBottomSheetState
    extends State<PhotoPickerBottomSheet> {

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = "Guest User";
    bioController.text = "Add your bio";
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
                    _optionTile(
                      icon:
                          Icons.camera_alt_outlined,

                      title: localizations.text('takePhoto'),

                      iconBg:
                          const Color(0xFFE8F7EA),

                      iconColor:
                          const Color(0xFF0B5D1E),
                    ),

                    const SizedBox(height: 14),

                    /// GALLERY
                    _optionTile(
                      icon: Icons.image_outlined,

                      title:
                          localizations.text('chooseGallery'),

                      iconBg:
                          const Color(0xFFEAF2FF),

                      iconColor:
                          const Color(0xFF1565C0),
                    ),

                    const SizedBox(height: 14),


                    /// REMOVE PHOTO
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFFFF4F4),

                        borderRadius:
                            BorderRadius.circular(24),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.03),

                            blurRadius: 12,

                            offset:
                                const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          Container(
                            width: 50,
                            height: 50,

                            decoration:
                                const BoxDecoration(
                              color:
                                  Color(0xFFFFE2E2),

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
                              localizations.text('removeCurrentPhoto'),

                              style:
                                  GoogleFonts.poppins(
                                fontSize: 14,

                                fontWeight:
                                    FontWeight.w600,

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
        onPressed: () {

  final profileProvider =
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      );

  profileProvider.updateProfile(
  name: nameController.text.trim(),
  bio: bioController.text.trim(),
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
  @override
void dispose() {
  nameController.dispose();
  bioController.dispose();
  super.dispose();
}
}