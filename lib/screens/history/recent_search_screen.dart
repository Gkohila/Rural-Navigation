import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../localization/app_localizations.dart';
import '../../localization/language_provider.dart';

class RecentSearchScreen extends StatelessWidget {
  const RecentSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final languageCode =
    context.watch<LanguageProvider>().languageCode;

    final lang =
      AppLocalizations(languageCode);

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          lang.text('recentSearchHistory'),

          style: GoogleFonts.poppins(
            color: const Color(0xFF0B5D1E),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 12),

            child: IconButton(

              onPressed: () {},

              icon: const Icon(
                Icons.delete_outline,

                color: Color(0xFF0B5D1E),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 10),

                /// SEARCH BAR
                Container(
                  height: 56,

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(18),

                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),

                  child: Row(
                    children: [

                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText:
                                lang.text('searchHistory'),

                            hintStyle:
                                GoogleFonts.poppins(
                              color:
                                  Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                /// TODAY
                Text(
                  lang.text('today'),

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color:
                        const Color(0xFF0B5D1E),
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 16),

                historyCard(
                  Icons.directions_bus,
                  "Tenkasi  →  Chennai",
                  "${lang.text('bus')} • 8:30 AM",
                ),

                historyCard(
                  Icons.train,
                  "Courtallam  →  Madurai",
                  "${lang.text('train')} • 7:15 AM",
                ),

                historyCard(
                  Icons.location_on,
                  "Tirunelveli Bus Stand",
                  "${lang.text('location')} • 6:45 AM",
                ),

                const SizedBox(height: 20),

                /// YESTERDAY
                Text(
                  lang.text('yesterday'),

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color:
                        const Color(0xFF0B5D1E),
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 16),

                historyCard(
                  Icons.directions_bus,
                  "Tenkasi  →  Coimbatore",
                  "${lang.text('bus')} • 9:10 PM",
                ),

                historyCard(
                  Icons.location_on,
                  "Madurai Railway Station",
                  "${lang.text('location')} • 8:05 PM",
                ),

                historyCard(
                  Icons.train,
                  "Sengottai  →  Chennai Egmore",
                  "${lang.text('train')} • 5:40 PM",
                ),

                const SizedBox(height: 30),

                /// CLEAR BUTTON
                Container(
                  width: double.infinity,
                  height: 58,

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFEAF7EA),

                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        lang.text('clearAllHistory'),

                        style:
                            GoogleFonts.poppins(
                          color: Colors.red,
                          fontWeight:
                              FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget historyCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color: Colors.grey.shade200,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(0.03),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [

          /// ICON
          Container(
            height: 54,
            width: 54,

            decoration: BoxDecoration(
              color:
                  const Color(0xFFEAF7EA),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color:
                  const Color(0xFF0B5D1E),
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.w600,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,

                  style: GoogleFonts.poppins(
                    color:
                        Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          /// ARROW
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}