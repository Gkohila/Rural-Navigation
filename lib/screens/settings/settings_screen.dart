import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool voiceNavigation = true;
  bool highContrast = false;

  bool pushNotifications = true;
  bool delayAlerts = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF6F7F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),

        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "Settings & Privacy",

          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            fontSize: 24,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 16),

            child: Center(
              child: Text(
                "EN/தமிழ்",

                style: GoogleFonts.poppins(
                  color: const Color(0xFF0B5D1E),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 24,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 8),

            /// ACCOUNT
            sectionTitle("ACCOUNT"),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),

                    blurRadius: 10,

                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Row(
                children: [

                  CircleAvatar(
                    radius: 38,

                    backgroundColor: Colors.green.shade100,

                    child: CircleAvatar(
                      radius: 34,

                      backgroundColor: Colors.white,

                      child: Icon(
                        Icons.person,
                        size: 42,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          "Kohila",

                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "kohila@tenkasi.gov.in",

                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 12),

                        GestureDetector(

                          onTap: () {

                            showDialog(

                              context: context,

                              builder: (context) {

                                return AlertDialog(

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),

                                  title: Text(
                                    "Edit Profile",

                                    style: GoogleFonts.poppins(
                                      fontWeight:
                                          FontWeight.w700,
                                    ),
                                  ),

                                  content: Column(
                                    mainAxisSize:
                                        MainAxisSize.min,

                                    children: [

                                      TextField(
                                        decoration:
                                            InputDecoration(
                                          labelText: "Name",

                                          border:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    12),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 16),

                                      TextField(
                                        decoration:
                                            InputDecoration(
                                          labelText: "Email",

                                          border:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  actions: [

                                    TextButton(

                                      onPressed: () {
                                        Navigator.pop(
                                            context);
                                      },

                                      child:
                                          const Text("Cancel"),
                                    ),

                                    ElevatedButton(

                                      style:
                                          ElevatedButton
                                              .styleFrom(
                                        backgroundColor:
                                            const Color(
                                                0xFF0B5D1E),
                                      ),

                                      onPressed: () {
                                        Navigator.pop(
                                            context);
                                      },

                                      child:
                                          const Text("Save"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },

                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFE8F5E9),

                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                            ),

                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,

                              children: [

                                Text(
                                  "Edit Profile",

                                  style:
                                      GoogleFonts.poppins(
                                    color:
                                        const Color(
                                            0xFF0B5D1E),

                                    fontWeight:
                                        FontWeight.w600,

                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(width: 4),

                                const Icon(
                                  Icons.edit,
                                  size: 14,
                                  color:
                                      Color(0xFF0B5D1E),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            /// ACCESSIBILITY
            sectionTitle("ACCESSIBILITY"),

            const SizedBox(height: 14),

            settingsCard(
              children: [

                switchTile(
                  Icons.record_voice_over_outlined,
                  "Voice Navigation",
                  voiceNavigation,

                  (value) {
                    setState(() {
                      voiceNavigation = value;
                    });
                  },
                ),

                divider(),

                switchTile(
                  Icons.visibility_outlined,
                  "High Contrast Mode",
                  highContrast,

                  (value) {
                    setState(() {
                      highContrast = value;
                    });
                  },
                ),

                divider(),

                listTile(
                  Icons.text_fields,
                  "Font Size",
                  trailing: "Default (16px)",
                ),
              ],
            ),

            const SizedBox(height: 26),

            /// NOTIFICATIONS
            sectionTitle("NOTIFICATIONS"),

            const SizedBox(height: 14),

            settingsCard(
              children: [

                switchTile(
                  Icons.notifications_active_outlined,
                  "Push Notifications",
                  pushNotifications,

                  (value) {
                    setState(() {
                      pushNotifications = value;
                    });
                  },
                ),

                divider(),

                switchTile(
                  Icons.warning_amber_rounded,
                  "Delay Alerts",
                  delayAlerts,

                  (value) {
                    setState(() {
                      delayAlerts = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 26),

            /// PRIVACY
            sectionTitle("PRIVACY"),

            const SizedBox(height: 14),

            settingsCard(
              children: [

                listTile(
                  Icons.location_on_outlined,
                  "Location Permissions",
                ),

                divider(),

                listTile(
                  Icons.share_outlined,
                  "Data Sharing Settings",
                ),

                divider(),

                listTile(
                  Icons.security,
                  "Two-Factor Auth",
                  trailing: "Enabled",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {

    return Padding(
      padding: const EdgeInsets.only(left: 4),

      child: Text(
        text,

        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,

          letterSpacing: 1.2,

          fontSize: 15,

          color: const Color(0xFF0B5D1E),
        ),
      ),
    );
  }

  Widget settingsCard({
    required List<Widget> children,
  }) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.03),

            blurRadius: 10,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        children: children,
      ),
    );
  }

  Widget switchTile(
    IconData icon,
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 8,
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF1565C0),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,

              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Switch(
            value: value,

            activeColor: const Color(0xFF0B5D1E),

            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget listTile(
    IconData icon,
    String title, {
    String? trailing,
  }) {

    return ListTile(

      leading: Icon(
        icon,
        color: const Color(0xFF1565C0),
      ),

      title: Text(
        title,

        style: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: trailing != null

          ? Text(
              trailing,

              style: GoogleFonts.poppins(
                color: const Color(0xFF0B5D1E),

                fontWeight: FontWeight.w600,
              ),
            )

          : const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
    );
  }

  Widget divider() {

    return Divider(
      height: 1,
      color: Colors.grey.shade200,
    );
  }
}