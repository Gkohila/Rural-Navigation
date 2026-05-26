import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveNavigationScreen extends StatelessWidget {
  const LiveNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [

          /// MAP BACKGROUND
          Positioned.fill(
            child: Image.network(
              "https://i.imgur.com/f0Vw6Yw.png",
              fit: BoxFit.cover,
            ),
          ),

          /// TOP BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [

                  /// BACK BUTTON
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),

                  /// TITLE
                  Text(
                    "Live Navigation",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B5D1E),
                    ),
                  ),

                  /// SOUND BUTTON
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.volume_up_outlined,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// FLOATING BUTTONS
          Positioned(
            right: 18,
            top: 300,
            child: Column(
              children: [

                floatingButton(Icons.my_location),

                const SizedBox(height: 16),

                floatingButton(Icons.layers_outlined),
              ],
            ),
          ),

          /// BOTTOM SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(
                22,
                18,
                22,
                26,
              ),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(34),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// DRAG LINE
                  Container(
                    width: 70,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// INFO SECTION
                  Row(
                    children: [

                      infoCard(
                        title: "ETA",
                        value: "12 min",
                      ),

                      divider(),

                      infoCard(
                        title: "Distance",
                        value: "4.5 km",
                      ),

                      divider(),

                      infoCard(
                        title: "Next Stop",
                        value: "Courtallam",
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  /// VOICE NAVIGATION BOX
                  Container(
                    height: 58,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7EA),
                      borderRadius:
                          BorderRadius.circular(18),
                    ),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [

                        const Icon(
                          Icons.volume_up,
                          color: Color(0xFF0B5D1E),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          "Voice Navigation ON",
                          style: GoogleFonts.poppins(
                            color:
                                const Color(0xFF0B5D1E),
                            fontWeight:
                                FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// END TRIP BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 64,

                    child: ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFFFF4D5A),

                        elevation: 0,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),

                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          /// WHITE CIRCLE
                          Container(
                            height: 32,
                            width: 32,

                            decoration:
                                const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.stop,
                              color:
                                  Color(0xFFFF4D5A),
                              size: 18,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Text(
                            "End Trip",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// FLOATING BUTTON
  Widget floatingButton(IconData icon) {
    return Container(
      height: 58,
      width: 58,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Icon(
        icon,
        color: Colors.black87,
      ),
    );
  }

  /// DIVIDER
  Widget divider() {
    return Container(
      height: 50,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  /// INFO CARD
  Widget infoCard({
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [

          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0B5D1E),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}