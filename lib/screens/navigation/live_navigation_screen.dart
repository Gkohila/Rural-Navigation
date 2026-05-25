import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveNavigationScreen extends StatelessWidget {
  const LiveNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [

          /// MAP BACKGROUND
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1524661135-423995f22d0b',

              fit: BoxFit.cover,
            ),
          ),

          /// TOP BAR
          Positioned(
            top: 50,
            left: 16,
            right: 16,

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(18),
                  ),

                  child: Text(
                    "Live Navigation",

                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(
                    icon: const Icon(Icons.my_location),

                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM PANEL
          Align(
            alignment: Alignment.bottomCenter,

            child: Container(
              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(34),
                ),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Center(
                    child: Container(
                      width: 70,
                      height: 6,

                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,

                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Current Trip",

                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 20),

                  navigationTile(
                    Icons.access_time,
                    "ETA",
                    "12 mins",
                  ),

                  navigationTile(
                    Icons.route,
                    "Distance",
                    "4.5 km",
                  ),

                  navigationTile(
                    Icons.location_on,
                    "Next Stop",
                    "Courtallam",
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,

                        padding:
                            const EdgeInsets.symmetric(
                                vertical: 18),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: () {},

                      child: Text(
                        "End Trip",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget navigationTile(
    IconData icon,
    String title,
    String value,
  ) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.green.shade50,

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: Colors.green.shade700,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              title,

              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),

          Text(
            value,

            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}