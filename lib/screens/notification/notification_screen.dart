import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            color: Color(0xFF0B5D1E),
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          "Alerts",

          style: GoogleFonts.poppins(
            color: const Color(0xFF0B5D1E),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),

        actions: const [

          Padding(
            padding: EdgeInsets.only(right: 16),

            child: Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFF0B5D1E),
              size: 26,
            ),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [

          notificationCard(
            icon: Icons.directions_bus,
            title: "Bus Delayed",
            subtitle: "Tenkasi → Chennai bus delayed by 10 mins",
            time: "5 mins ago",
            color: Colors.red,
          ),

          notificationCard(
            icon: Icons.train,
            title: "Train Arriving",
            subtitle: "Madurai Express arriving at Platform 2",
            time: "10 mins ago",
            color: Colors.blue,
          ),

          notificationCard(
            icon: Icons.route,
            title: "Route Updated",
            subtitle: "New shortcut available for Courtallam route",
            time: "20 mins ago",
            color: Colors.green,
          ),

          notificationCard(
            icon: Icons.warning_amber_rounded,
            title: "Weather Alert",
            subtitle: "Heavy rain expected near Tirunelveli",
            time: "30 mins ago",
            color: Colors.orange,
          ),

          notificationCard(
            icon: Icons.security,
            title: "Emergency Alert",
            subtitle: "Traffic congestion near Tenkasi Bus Stand",
            time: "1 hour ago",
            color: Colors.deepOrange,
          ),
        ],
      ),
    );
  }

  Widget notificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: color.withOpacity(0.12),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Expanded(
                      child: Text(
                        title,

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      time,

                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,

                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
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