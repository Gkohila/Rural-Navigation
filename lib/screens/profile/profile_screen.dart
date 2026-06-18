import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../screens/settings/settings_screen.dart';
import '../../widgets/profile/photo_picker_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

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

          "Profile",

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

                        backgroundColor:
                            Colors.white,

                        child: CircleAvatar(

                          radius: 46,

                          backgroundColor:
                              const Color(
                                  0xFFE9F4EC),

                          child: Icon(

                            Icons.person,

                            size: 60,

                            color:
                                Colors.green.shade800,
                          ),
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
                                  trugit statuse,

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

                    "Kohila",

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

                        "Travel Explorer",

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
            sectionTitle("QUICK ACTIONS"),

            const SizedBox(height: 18),

            GridView.count(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              childAspectRatio: 1.12,

              children: [

                quickCard(
                  Icons.route,
                  "Saved Routes",
                  Colors.blue,
                ),

                quickCard(
                  Icons.favorite,
                  "Favorites",
                  Colors.green,
                ),

                quickCard(
                  Icons.download,
                  "Offline Maps",
                  Colors.brown,
                ),

                quickCard(
                  Icons.history,
                  "Travel History",
                  Colors.lightBlue,
                ),
              ],
            ),

            const SizedBox(height: 34),

            /// RECENT ACTIVITY
            Row(

              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                sectionTitle("RECENT ACTIVITY"),

                Text(

                  "View All",

                  style: GoogleFonts.poppins(

                    color:
                        const Color(0xFF0B5D1E),

                    fontSize: 14,

                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            activityCard(
              Icons.directions_bus,
              "Tenkasi → Chennai",
              "Luxury Bus • 8h journey",
              "Oct 12",
              Colors.green,
            ),

            activityCard(
              Icons.train,
              "Courtallam → Madurai",
              "Express Train • 3h journey",
              "Oct 10",
              Colors.blue,
            ),

            activityCard(
              Icons.directions_bus,
              "Tirunelveli → CBE",
              "Intercity Bus • 6h journey",
              "Oct 5",
              Colors.green,
            ),

            const SizedBox(height: 34),

            /// SETTINGS
            sectionTitle("SETTINGS & PRIVACY"),

            const SizedBox(height: 18),

            Container(

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.03),

                    blurRadius: 8,

                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(

                children: [

                  settingsTile(
                    Icons.dark_mode_outlined,
                    "Dark Mode",
                  ),

                  settingsTile(
                    Icons.language,
                    "Language",
                    trailing: "English",
                  ),

                  settingsTile(
                    Icons.lock_outline,
                    "Privacy Policy",
                  ),

                  settingsTile(
                    Icons.logout,
                    "Logout",
                    iconColor: Colors.red,
                    textColor: Colors.red,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
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
                  color.withOpacity(0.14),

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

          Text(

            title,

            style: GoogleFonts.poppins(

              fontSize: 15,

              fontWeight: FontWeight.w600,

              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  /// ACTIVITY CARD
  Widget activityCard(
    IconData icon,
    String route,
    String type,
    String date,
    Color color,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          CircleAvatar(

            radius: 25,

            backgroundColor:
                color.withOpacity(0.12),

            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  route,

                  style: GoogleFonts.poppins(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.w600,

                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 4),

                Text(

                  type,

                  style: GoogleFonts.poppins(

                    color: Colors.black54,

                    fontSize: 13,

                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Text(

            date,

            style: GoogleFonts.poppins(

              fontSize: 13,

              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  /// SETTINGS TILE
  Widget settingsTile(
    IconData icon,
    String title, {
    Color iconColor = Colors.black54,
    Color textColor = Colors.black87,
    String? trailing,
  }) {

    return ListTile(

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 2,
      ),

      leading: Icon(
        icon,
        color: iconColor,
      ),

      title: Text(

        title,

        style: GoogleFonts.poppins(

          color: textColor,

          fontSize: 15,

          fontWeight: FontWeight.w500,

          height: 1.2,
        ),
      ),

      trailing: trailing != null

          ? Text(

              trailing,

              style: GoogleFonts.poppins(
                fontSize: 13,
              ),
            )

          : const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
    );
  }
}