import 'package:flutter/material.dart';

class DirectionPreviewCard extends StatelessWidget {
  final int transportIndex;
  final String source;
  final String destination;

  const DirectionPreviewCard({
    super.key,
    required this.transportIndex,
    required this.source,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    String duration = "";
    String arrivalTime = "";
    String distance = "";

    List<Map<String, dynamic>> directions = [];

    /// CAR
    if (transportIndex == 0) {
      duration = "23 min";
      arrivalTime = "03:00 PM";
      distance = "19 km";

      directions = [
        {
          "icon": Icons.north,
          "title": "Head north on NH744",
          "distance": "5.2 km",
        },
        {
          "icon": Icons.north,
          "title": "Continue on NH744",
          "distance": "11.8 km",
        },
        {
          "icon": Icons.turn_right,
          "title": "Turn right",
          "distance": "1.3 km",
        },
        {
          "icon": Icons.north,
          "title": "Continue straight",
          "distance": "700 m",
        },
      ];
    }

    /// BIKE
    if (transportIndex == 1) {
      duration = "19 min";
      arrivalTime = "02:56 PM";
      distance = "18 km";

      directions = [
        {
          "icon": Icons.north,
          "title": "Take bike route",
          "distance": "4 km",
        },
        {
          "icon": Icons.turn_right,
          "title": "Continue straight",
          "distance": "9 km",
        },
        {
          "icon": Icons.north,
          "title": "Reach destination",
          "distance": "5 km",
        },
      ];
    }

    /// WALK
    if (transportIndex == 3) {
      duration = "1 hr 38 min";
      arrivalTime = "04:10 PM";
      distance = "6 km";

      directions = [
        {
          "icon": Icons.directions_walk,
          "title": "Walk towards NH744",
          "distance": "500 m",
        },
        {
          "icon": Icons.turn_right,
          "title": "Cross road",
          "distance": "1 km",
        },
        {
          "icon": Icons.directions_walk,
          "title": "Continue straight",
          "distance": "4.5 km",
        },
      ];
    }

    return Column(
      children: [
        _direction(
          Icons.my_location,
          source,
          "",
        ),

        ...directions.map(
          (step) => _direction(
            step["icon"],
            step["title"],
            step["distance"],
          ),
        ),

        _direction(
          Icons.location_on,
          destination,
          "",
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        Text(
                          duration,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "$distance • Arrive at $arrivalTime",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 140,
                    height: 52,

                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/liveNavigation",
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF137A1B),

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),

                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.navigation,
                            color: Colors.white,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Divider(
                color: Colors.grey.shade300,
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.bookmark_border,
                      ),

                      label: const Text(
                        "Save",
                      ),

                      style:
                          OutlinedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(
                          50,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.share,
                      ),

                      label: const Text(
                        "Share",
                      ),

                      style:
                          OutlinedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(
                          50,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _direction(
    IconData icon,
    String title,
    String distance,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 22,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.black87,
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                if (distance.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(
                      top: 4,
                    ),

                    child: Text(
                      distance,

                      style: TextStyle(
                        fontSize: 14,
                        color:
                            Colors.grey.shade600,
                      ),
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