
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertDetailsScreen extends StatelessWidget {
  const AlertDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon:
                          const Icon(Icons.arrow_back),
                    ),

                    const Text(
                      "Alert Details",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),

                    Row(
                      children: const [

                        Icon(Icons.bookmark_border),

                        SizedBox(width: 18),

                        Icon(Icons.share),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// ALERT BOX
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFF5EEFF),

                    borderRadius:
                        BorderRadius.circular(26),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Row(
                        children: [

                          Container(
                            height: 64,
                            width: 64,

                            decoration:
                                const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),

                            child: const Icon(
                              Icons.directions_bus,
                              color: Colors.deepPurple,
                              size: 36,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color: Colors
                                        .deepPurple,

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                30),
                                  ),

                                  child: const Text(
                                    "Bus Update",

                                    style: TextStyle(
                                      color:
                                          Colors.white,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    height: 12),

                                const Text(
                                  "Bus Halted for Ticket Checking",

                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),

                                const SizedBox(
                                    height: 8),

                                const Text(
                                  "Tenkasi → Courtallam",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color:
                              Colors.deepPurple
                                  .withOpacity(0.1),

                          borderRadius:
                              BorderRadius.circular(
                                  30),
                        ),

                        child: const Text(
                          "Expected delay: 10–15 mins",

                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                /// LIVE LOCATION
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: const [

                    Text(
                      "Live Location",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),

                    Text(
                      "View on Map",

                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// MAP
                Container(
                  height: 240,

                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(24),

                    child: GoogleMap(

                      initialCameraPosition:
                          const CameraPosition(
                        target:
                            LatLng(8.9342, 77.2778),
                        zoom: 12,
                      ),

                      markers: {

                        const Marker(
                          markerId:
                              MarkerId("bus"),

                          position:
                              LatLng(
                            8.9342,
                            77.2778,
                          ),
                        ),
                      },

                      zoomControlsEnabled:
                          false,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  "Current Status",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 18),

                statusTile(
                  "9:20 AM",
                  "Bus departed from Tenkasi Bus Stand",
                  Colors.green,
                ),

                statusTile(
                  "9:35 AM",
                  "Halted at Shenkottai Check Post",
                  Colors.deepPurple,
                ),

                statusTile(
                  "9:50 AM",
                  "Expected to resume journey",
                  Colors.grey,
                ),

                const SizedBox(height: 28),

                /// SHARE BUTTON
                Container(
                  width: double.infinity,
                  height: 64,

                  decoration: BoxDecoration(
                    color: Colors.deepPurple,

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Center(
                    child: Text(
                      "Share this Alert",

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                /// SAVE BUTTON
                Container(
                  width: double.infinity,
                  height: 64,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                    ),

                    borderRadius:
                        BorderRadius.circular(20),
                  ),

                  child: const Center(
                    child: Text(
                      "Save Alert",

                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusTile(
    String time,
    String text,
    Color color,
  ) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [

          CircleAvatar(
            radius: 8,
            backgroundColor: color,
          ),

          const SizedBox(width: 14),

          Text(
            time,

            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}