import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/settings/settings_screen.dart';
import '../../widgets/profile/photo_picker_bottom_sheet.dart';

import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

import '../../providers/profile_provider.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final profileProvider =
    Provider.of<ProfileProvider>(context);

    final languageProvider =
    Provider.of<LanguageProvider>(context);

final localizations =
    AppLocalizations(
      languageProvider.languageCode,
    );

    return Scaffold(

      backgroundColor: const Color(0xFFF6F7F9),

      appBar: AppBar(

        backgroundColor: const Color(0xFFF6F7F9),

        elevation: 0,

        centerTitle: false,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0B5D1E),
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(

          localizations.text('profile'),

          style: GoogleFonts.poppins(

            color: const Color(0xFF0B5D1E),

            fontWeight: FontWeight.w700,

            fontSize: 22,

            letterSpacing: 0.3,
          ),
        ),

        actions: [

          Padding(

            padding: const EdgeInsets.only(right: 10),

            child: IconButton(

              icon: const Icon(
                Icons.settings_outlined,
                color: Color(0xFF0B5D1E),
                size: 26,
              ),

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const SettingsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            /// PROFILE CARD
            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 22,
              ),

              decoration: BoxDecoration(

                color: const Color(0xFFDFF5EC),

                borderRadius:
                    BorderRadius.circular(30),
              ),

              child: Column(

                children: [

                  Stack(

                    children: [
CircleAvatar(
  radius: 52,
  backgroundColor: Colors.white,

  child: CircleAvatar(
    radius: 46,

    backgroundColor: const Color(0xFFE9F4EC),

    backgroundImage:
        profileProvider.profile.imagePath != null
            ? FileImage(
                File(
                  profileProvider.profile.imagePath!,
                ),
              )
            : null,

    child:
        profileProvider.profile.imagePath == null
            ? Icon(
                Icons.person,
                size: 60,
                color: Colors.green.shade800,
              )
            : null,
  ),
),

                      Positioned(

                        bottom: 0,
                        right: 0,

                        child: GestureDetector(

                          onTap: () {

                            showModalBottomSheet(

                              context: context,

                              backgroundColor:
                                  Colors.transparent,

                              isScrollControlled:
                                  true,

                              builder: (context) {

                                return const PhotoPickerBottomSheet();
                              },
                            );
                          },

                          child: Container(

                            padding:
                                const EdgeInsets.all(8),

                            decoration:
                                const BoxDecoration(

                              color:
                                  Color(0xFF0B5D1E),

                              shape: BoxShape.circle,
                            ),

                            child: const Icon(

                              Icons.edit,

                              color: Colors.white,

                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(

                     profileProvider.profile.name,

                    style: GoogleFonts.poppins(

                      fontSize: 28,

                      fontWeight: FontWeight.w700,

                      color:
                          const Color(0xFF0B5D1E),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.public,
                        size: 16,
                        color: Colors.black54,
                      ),

                      const SizedBox(width: 6),

                      Text(

                         profileProvider.profile.bio,

                        style: GoogleFonts.poppins(

                          fontSize: 14,

                          color: Colors.black54,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            /// QUICK ACTIONS
            sectionTitle(localizations.text('quickActions')),

            const SizedBox(height: 18),

            GridView.count(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio: 1.3,

              children: [

                quickCard(
                  Icons.route,
                   localizations.text('savedRoutes'),
                  Colors.blue,
                ),

                quickCard(
                  Icons.favorite,
                  localizations.text('favorites'),
                  Colors.green,
                ),

                quickCard(
                  Icons.download,
                  localizations.text('offlineMaps'),
                  Colors.brown,
                ),

                quickCard(
                  Icons.history,
                  localizations.text('travelHistory'),
                  Colors.lightBlue,
                ),
              ],
            ),

            const SizedBox(height: 24),

/// APP INFORMATION
Container(
  width: double.infinity,

  padding: const EdgeInsets.all(20),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),

    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.03),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),

  child: Column(
    children: [

      const Icon(
        Icons.navigation,
        size: 35,
        color: Color(0xFF0B5D1E),
      ),

      const SizedBox(height: 12),

      Text(
         localizations.text('tenkasiSmartNav'),
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF0B5D1E),
        ),
      ),

      const SizedBox(height: 8),

      Text(
         localizations.text('appDescription'),
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: Colors.black54,
          height: 1.5,
        ),
      ),

      const SizedBox(height: 12),

      Text(
        localizations.text('version'),
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    ],
  ),
),

const SizedBox(height: 20),

Center(
  child: Text(
    "© 2026 ${localizations.text('tenkasiSmartNav')}",
    style: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.grey,
    ),
  ),
),

const SizedBox(height: 10),
            
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget sectionTitle(String text) {

    return Text(

      text,

      style: GoogleFonts.poppins(

        fontSize: 15,

        fontWeight: FontWeight.w700,

        letterSpacing: 1.2,

        color: Colors.black54,
      ),
    );
  }

  /// QUICK CARD
  Widget quickCard(
    IconData icon,
    String title,
    Color color,
  ) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Container(

            padding:
                const EdgeInsets.all(12),

            decoration: BoxDecoration(

              color:
                  color.withValues(alpha: 0.14),

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),

          const SizedBox(height: 18),

          Expanded(
  child: Text(
    title,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
  ),
)
        ],
      ),
    );
  }
}