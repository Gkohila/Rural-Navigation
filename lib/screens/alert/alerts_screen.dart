import 'package:flutter/material.dart';
import 'alert_details_screen.dart';

import 'package:smartnav/widgets/home/bottom_navbar.dart';

import 'package:smartnav/screens/profile/profile_screen.dart';

import 'package:smartnav/features/maps/screens/route_search_screen.dart';


class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

     bottomNavigationBar: HomeBottomNavbar(

  selectedItem:
      HomeNavItem.alerts,

  onItemSelected: (item) {

    /// HOME
    if (item == HomeNavItem.home) {

      Navigator.pop(context);
    }

    /// ROUTES
    if (item == HomeNavItem.routes) {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const RouteSearchScreen(),
        ),
      );
    }

    /// PROFILE
    if (item == HomeNavItem.profile) {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              const ProfileScreen(),
        ),
      );
    }
  },
),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Row(
                      children: [

                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(
                             "https://i.imgur.com/QCNbOAo.png",
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Text(
                          "Tenkasi SmartNav",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B5D1E),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [

                        const Text(
                          "EN/தமிழ்",

                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Stack(
                          children: [

                            const Icon(
                              Icons.notifications_none,
                              size: 30,
                              color: Color(0xFF0B5D1E),
                            ),

                            Positioned(
                              right: 0,

                              child: Container(
                                padding:
                                    const EdgeInsets.all(4),

                                decoration:
                                    const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),

                                child: const Text(
                                  "3",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  "Alerts & Notifications",

                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Real-time updates on buses, routes, traffic & weather",

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 26),

                /// LIVE MONITORING
                Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(22),
                  ),

                  child: Row(
                    children: [

                      Container(
                        height: 54,
                        width: 54,

                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF7EA),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.wifi,
                          color: Color(0xFF0B5D1E),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Live monitoring active",

                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "We’ll notify you instantly about any changes",

                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor:
                            const Color(0xFF0B5D1E),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// CATEGORY BUTTONS
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    categoryChip(
                      "All",
                      "12",
                      const Color(0xFF0B5D1E),
                    ),

                    categoryChip(
                      "Bus",
                      "4",
                      Colors.deepPurple,
                    ),

                    categoryChip(
                      "Traffic",
                      "3",
                      Colors.orange,
                    ),

                    categoryChip(
                      "Weather",
                      "2",
                      Colors.blue,
                    ),

                    categoryChip(
                      "Info",
                      "3",
                      Colors.green,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// SMART ALERT
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8EA),

                    borderRadius:
                        BorderRadius.circular(24),

                    border: Border.all(
                      color: Colors.orange.shade100,
                    ),
                  ),

                  child: Row(
                    children: [

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Row(
                              children: [

                                Text(
                                  "Smart Auto Alerts",

                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),

                                SizedBox(width: 8),

                                Chip(
                                  label: Text("AI"),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            Text(
                              "Alerts are generated automatically using live bus GPS, traffic and weather data.",

                              style: TextStyle(
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.memory,
                        size: 48,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Today",

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                /// ALERT CARD
                GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const AlertDetailsScreen(),
                      ),
                    );
                  },

                  child: alertCard(
                    color: Colors.deepPurple,
                    title:
                        "Bus Halted for Ticket Checking",

                    subtitle:
                        "Tenkasi → Courtallam bus is stopped near Shenkottai Check Post.",

                    delay:
                        "Expected delay: 10–15 mins",

                    location:
                        "Shenkottai Check Post",

                    priority: "High",
                  ),
                ),

                const SizedBox(height: 18),

                alertCard(
                  color: Colors.orange,
                  title:
                      "Heavy Traffic near Five Falls",

                  subtitle:
                      "Traffic is moving slower than usual.",

                  delay:
                      "Expect delays up to 15 mins.",

                  location:
                      "Five Falls, Courtallam",

                  priority: "Medium",
                ),

                const SizedBox(height: 18),

                alertCard(
                  color: Colors.blue,
                  title: "Rain expected at 6 PM",

                  subtitle:
                      "Moderate to heavy rain expected in Courtallam by 6:00 PM.",

                  delay: "",

                  location: "Courtallam",

                  priority: "Low",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryChip(
    String title,
    String count,
    Color color,
  ) {

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Column(
        children: [

          CircleAvatar(
            radius: 10,
            backgroundColor:
                color.withOpacity(0.15),

            child: Text(
              count,

              style: TextStyle(
                fontSize: 10,
                color: color,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            title,

            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget alertCard({
    required Color color,
    required String title,
    required String subtitle,
    required String delay,
    required String location,
    required String priority,
  }) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            height: 64,
            width: 64,

            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.directions_bus,
              color: color,
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Expanded(
                      child: Text(
                        title,

                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,

                          fontSize: 18,
                        ),
                      ),
                    ),

                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),

                      decoration: BoxDecoration(
                        color:
                            color.withOpacity(0.12),

                        borderRadius:
                            BorderRadius.circular(
                                30),
                      ),

                      child: Text(
                        priority,

                        style: TextStyle(
                          color: color,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(
                  subtitle,

                  style: const TextStyle(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  delay,

                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [

                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: color,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      location,

                      style: TextStyle(
                        color: color,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    OutlinedButton(
                      onPressed: () {},

                      child: const Text(
                        "View Details",
                      ),
                    ),

                    const Row(
                      children: [

                        Icon(
                          Icons.share,
                          size: 18,
                        ),

                        SizedBox(width: 6),

                        Text("Share"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}