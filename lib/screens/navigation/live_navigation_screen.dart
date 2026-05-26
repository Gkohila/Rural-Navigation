import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveNavigationScreen extends StatelessWidget {
  const LiveNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: Column(
          children: [

            /// TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 14,
              ),

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    "Live Navigation",

                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0B5D1E),
                    ),
                  ),

                  const Icon(
                    Icons.volume_up_outlined,
                    color: Colors.black,
                    size: 28,
                  ),
                ],
              ),
            ),

            /// MAP SECTION
            Expanded(

              child: Stack(

                children: [

                  /// GOOGLE MAP
                  Positioned.fill(

                    child: GoogleMap(

                      initialCameraPosition:
                          const CameraPosition(

                        target: LatLng(
                          8.9342,
                          77.2778,
                        ),

                        zoom: 13,
                      ),

                      markers: {

                        const Marker(
                          markerId: MarkerId("start"),

                          position: LatLng(
                            8.9290,
                            77.2730,
                          ),
                        ),

                        const Marker(
                          markerId: MarkerId("end"),

                          position: LatLng(
                            8.9342,
                            77.2778,
                          ),
                        ),
                      },

                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),

                  /// RIGHT BUTTONS
                  Positioned(
                    right: 18,
                    top: 220,

                    child: Column(
                      children: [

                        mapButton(Icons.my_location),

                        const SizedBox(height: 16),

                        mapButton(Icons.layers_outlined),
                      ],
                    ),
                  ),

                  /// BOTTOM CARD
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,

                    child: Container(

                      padding: const EdgeInsets.all(22),

                      decoration: const BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(34),
                          topRight: Radius.circular(34),
                        ),
                      ),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [

                          /// INFO ROW
                          Row(

                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,

                            children: [

                              infoColumn(
                                "ETA",
                                "12 min",
                              ),

                              divider(),

                              infoColumn(
                                "Distance",
                                "4.5 km",
                              ),

                              divider(),

                              infoColumn(
                                "Next Stop",
                                "Courtallam",
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          /// VOICE NAVIGATION
                          Container(

                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 18,
                            ),

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

                                  style:
                                      GoogleFonts.poppins(
                                    fontWeight:
                                        FontWeight.w600,

                                    color:
                                        const Color(
                                            0xFF0B5D1E),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 22),

                          /// END TRIP BUTTON
                          Container(

                            width: double.infinity,
                            height: 66,

                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20),

                              color: const Color(0xFFCC2B3E),
                            ),

                            child: Center(

                              child: Text(
                                "End Trip",

                                style:
                                    GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.w700,

                                  fontSize: 18,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget mapButton(IconData icon) {

    return Container(

      height: 62,
      width: 62,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
          ),
        ],
      ),

      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }

  Widget divider() {

    return Container(
      height: 42,
      width: 1,
      color: Colors.grey.shade300,
    );
  }

  Widget infoColumn(
    String title,
    String value,
  ) {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          title,

          style: GoogleFonts.poppins(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value,

          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: const Color(0xFF0B5D1E),
          ),
        ),
      ],
    );
  }
}