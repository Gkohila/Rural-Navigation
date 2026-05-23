import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotoPickerBottomSheet extends StatelessWidget {
  const PhotoPickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
                            "Update Photo",

                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight:
                                  FontWeight.w700,
                              color:
                                  const Color(0xFF0B5D1E),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Personalize your Tenkasi profile",

                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// CAMERA
                    _optionTile(
                      icon:
                          Icons.camera_alt_outlined,

                      title: "Take Photo",

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
                          "Choose from Gallery",

                      iconBg:
                          const Color(0xFFEAF2FF),

                      iconColor:
                          const Color(0xFF1565C0),
                    ),

                    const SizedBox(height: 14),

                    /// FACEBOOK
                    _optionTile(
                      icon: Icons.facebook,

                      title:
                          "Import from Facebook",

                      iconBg:
                          const Color(0xFFEAF0FF),

                      iconColor:
                          const Color(0xFF1877F2),
                    ),

                    const SizedBox(height: 14),

                    /// AI AVATAR
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(24),

                        border: Border.all(
                          color:
                              const Color(0xFFEAEAEA),
                        ),

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
                            width: 56,
                            height: 56,

                            decoration:
                                const BoxDecoration(
                              shape: BoxShape.circle,

                              gradient:
                                  LinearGradient(
                                colors: [
                                  Color(0xFF1C4B1A),
                                  Color(0xFF0B5D1E),
                                ],
                              ),
                            ),

                            child: const Icon(
                              Icons.auto_awesome,

                              color: Colors.white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Text(
                                  "Generate AI Avatar",

                                  style:
                                      GoogleFonts.poppins(
                                    fontSize: 16,

                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(
                                    height: 5),

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                            0xFFFFE5D9),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                8),
                                  ),

                                  child: Text(
                                    "PREMIUM",

                                    style:
                                        GoogleFonts
                                            .poppins(
                                      fontSize: 10,

                                      fontWeight:
                                          FontWeight
                                              .w700,

                                      color:
                                          const Color(
                                              0xFFE57D45),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black38,
                          ),
                        ],
                      ),
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
                            width: 56,
                            height: 56,

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
                              "Remove Current Photo",

                              style:
                                  GoogleFonts.poppins(
                                fontSize: 16,

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

                    /// CANCEL BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(

                        style:
                            ElevatedButton.styleFrom(
                          elevation: 0,

                          backgroundColor:
                              const Color(
                                  0xFFF3F4F6),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    24),
                          ),
                        ),

                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: Text(
                          "Cancel",

                          style:
                              GoogleFonts.poppins(
                            fontSize: 18,

                            fontWeight:
                                FontWeight.w500,

                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// PRIVACY TEXT
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        const Icon(
                          Icons.lock_outline,
                          size: 15,
                          color: Colors.black45,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "Your photo is private and secure",

                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
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
            width: 56,
            height: 56,

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
                fontSize: 16,
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
}