import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearbyStopsScreen extends StatelessWidget {
  const NearbyStopsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Column(
          children: [

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),

              child: Row(

                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),

                  Expanded(
                    child: Center(

                      child: Text(
                        "Nearby Stops",

                        style:
                            GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight:
                              FontWeight.w700,

                          color:
                              const Color(
                                  0xFF0B5D1E),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 40),
                ],
              ),
            ),

            /// SEARCH BAR
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Container(

                height: 58,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(18),

                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),

                child: Row(
                  children: [

                    const SizedBox(width: 16),

                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "Search nearby stops...",

                      style:
                          GoogleFonts.poppins(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// MAP
            Stack(

              children: [

                Image.network(
                  "https://i.imgur.com/aq2fM6p.png",

                  height: 220,
                  width: double.infinity,

                  fit: BoxFit.cover,
                ),

                Positioned(
                  right: 18,
                  bottom: 18,

                  child: Container(

                    height: 58,
                    width: 58,

                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.my_location,
                    ),
                  ),
                ),
              ],
            ),

            /// TITLE
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),

              child: Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Stops Near You",

                  style:
                      GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.w700,

                    fontSize: 22,

                    color:
                        const Color(
                            0xFF0B5D1E),
                  ),
                ),
              ),
            ),

            /// LIST
            Expanded(

              child: ListView(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                children: [

                  stopCard(
                    "Courtallam Bus Stop",
                    "Bus Stop",
                    "200 m away",
                  ),

                  stopCard(
                    "Tenkasi Railway Station",
                    "Railway Station",
                    "1.2 km away",
                  ),

                  stopCard(
                    "Main Auto Stand",
                    "Auto Stand",
                    "350 m away",
                  ),

                  stopCard(
                    "Old Bus Stand",
                    "Bus Stop",
                    "650 m away",
                  ),

                  const SizedBox(height: 18),

                  Container(

                    height: 64,

                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7EA),

                      borderRadius:
                          BorderRadius.circular(20),
                    ),

                    child: Row(

                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        Text(
                          "View More",

                          style:
                              GoogleFonts.poppins(
                            fontWeight:
                                FontWeight.w600,

                            color:
                                const Color(
                                    0xFF0B5D1E),
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF0B5D1E),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stopCard(
    String title,
    String type,
    String distance,
  ) {

    return Container(

      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),

      child: Row(
        children: [

          Container(

            height: 62,
            width: 62,

            decoration: BoxDecoration(
              color: const Color(0xFFEAF7EA),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: const Icon(
              Icons.directions_bus,
              color: Color(0xFF0B5D1E),
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                      GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.w700,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  type,

                  style:
                      GoogleFonts.poppins(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  distance,

                  style:
                      GoogleFonts.poppins(
                    color:
                        const Color(
                            0xFF0B5D1E),

                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Container(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFF0B5D1E),

              borderRadius:
                  BorderRadius.circular(30),
            ),

            child: Row(
              children: [

                const Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 18,
                ),

                const SizedBox(width: 6),

                Text(
                  "Directions",

                  style:
                      GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}