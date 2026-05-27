import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                horizontal: 16,
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
                      color: Colors.black,
                      size: 22,
                    ),
                  ),

                  Expanded(

                    child: Center(

                      child: Text(
                        "Nearby Stops",

                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0B5D1E),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 42),
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

                height: 54,

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

                    Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "Search nearby stops...",

                      style:
                          GoogleFonts.poppins(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// MAP SECTION
            SizedBox(

              height: 180,

              child: Stack(

                children: [

                  GoogleMap(

                    initialCameraPosition:
                        const CameraPosition(

                      target: LatLng(
                        8.9342,
                        77.2778,
                      ),

                      zoom: 14,
                    ),

                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,

                    markers: {

                      const Marker(
                        markerId: MarkerId("1"),

                        position: LatLng(
                          8.9342,
                          77.2778,
                        ),
                      ),

                      const Marker(
                        markerId: MarkerId("2"),

                        position: LatLng(
                          8.9380,
                          77.2810,
                        ),
                      ),

                      const Marker(
                        markerId: MarkerId("3"),

                        position: LatLng(
                          8.9300,
                          77.2700,
                        ),
                      ),

                      const Marker(
                        markerId: MarkerId("4"),

                        position: LatLng(
                          8.9270,
                          77.2790,
                        ),
                      ),

                      const Marker(
                        markerId: MarkerId("5"),

                        position: LatLng(
                          8.9360,
                          77.2720,
                        ),
                      ),
                    },
                  ),

                  /// BLUE RADIUS
                  Center(

                    child: Container(

                      height: 80,
                      width: 80,

                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  /// BLUE DOT
                  Center(

                    child: Container(

                      height: 16,
                      width: 16,

                      decoration: BoxDecoration(
                        color: Colors.blue,

                        shape: BoxShape.circle,

                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                  ),

                  /// LOCATION BUTTON
                  Positioned(
                    right: 18,
                    bottom: 18,

                    child: Container(

                      height: 56,
                      width: 56,

                      decoration:
                          BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,

                        boxShadow: [

                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.my_location,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// TITLE
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              child: Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  "Stops Near You",

                  style:
                      GoogleFonts.poppins(
                    fontWeight:
                        FontWeight.w700,

                    fontSize: 18,

                    color:
                        const Color(
                            0xFF0B5D1E),
                  ),
                ),
              ),
            ),

            /// STOP LIST
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

                  const SizedBox(height: 14),

                  /// VIEW MORE
                  Container(

                    height: 62,

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

                            fontSize: 15,
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

                  const SizedBox(height: 20),
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

      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,

        children: [

          /// ICON
          Container(

            height: 56,
            width: 56,

            decoration: BoxDecoration(
              color: const Color(0xFFEAF7EA),

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: const Icon(
              Icons.directions_bus,
              color: Color(0xFF0B5D1E),
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          /// TEXT
          Expanded(

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  maxLines: 2,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      GoogleFonts.poppins(

                    fontWeight:
                        FontWeight.w700,

                    fontSize: 16,

                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  type,

                  style:
                      GoogleFonts.poppins(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  distance,

                  style:
                      GoogleFonts.poppins(

                    color:
                        const Color(
                            0xFF0B5D1E),

                    fontWeight:
                        FontWeight.w700,

                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// BUTTON
          Container(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: const Color(0xFF0B5D1E),

              borderRadius:
                  BorderRadius.circular(30),
            ),

            child: Row(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                const Icon(
                  Icons.navigation,
                  color: Colors.white,
                  size: 14,
                ),

                const SizedBox(width: 5),

                Text(
                  "Directions",

                  style:
                      GoogleFonts.poppins(

                    color: Colors.white,

                    fontWeight:
                        FontWeight.w600,

                    fontSize: 12,
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