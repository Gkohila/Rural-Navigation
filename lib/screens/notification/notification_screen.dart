import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smartnav/models/alert_model.dart';
import 'package:smartnav/services/alert_service.dart';

import 'dart:async';
import 'package:smartnav/features/maps/services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen> {
  List<AlertModel> alerts = [];

  bool isLoading = true;
  int previousAlertCount = 0;
  int unreadCount = 0;
  final AlertService alertService = AlertService();
  Timer? timer;

  @override
void initState() {
  super.initState();

  loadAlerts();

  timer = Timer.periodic(
    const Duration(seconds: 15),
    (_) {
      loadAlerts();
    },
  );
}

  Future<void> loadAlerts() async {

  print("Loading alerts...");

  List<AlertModel> latestAlerts =
      await alertService.getAlerts(
          "147C");

  print(
      "Alert loaded = ${latestAlerts.length}");

  unreadCount =
      await alertService.getUnreadCount(
          "147C");

  print(
      "Unread Count = $unreadCount");

  if (previousAlertCount != 0 &&
      latestAlerts.length >
          previousAlertCount) {

    AlertModel newest =
        latestAlerts.first;

    await NotificationService
        .showAlertNotification(

      "Tenkasi SmartNav",

      newest.message,

    );
  }

  previousAlertCount =
      latestAlerts.length;

  if (!mounted) return;

  setState(() {

    alerts = latestAlerts;

    isLoading = false;

  });
}

  Future<void> loadUnreadCount() async {

    unreadCount = await alertService.getUnreadCount("147C");

    if (!mounted) return;

    setState(() {});
  }

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

      actions: [

        Padding(
          padding: const EdgeInsets.only(right: 16,),

          child: Stack(

            children: [

              const Icon(
                Icons.notifications_active_outlined,
                color: Color(0xFF0B5D1E),
                size: 26,
              ),

              if (unreadCount > 0)

                Positioned(

                  right: 0, top: 0,

                  child: Container(

                    padding:
                      const EdgeInsets.all(4),

                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),

                    child: Text(

                      unreadCount.toString(),

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight:
                          FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
    ),

    body: isLoading

        ? const Center(
            child: CircularProgressIndicator(),
          )

        : ListView.builder(

            padding: const EdgeInsets.all(16),

            itemCount: alerts.length,

            itemBuilder: (context, index) {

              AlertModel alert = alerts[index];

              return GestureDetector(

  onTap: () async {

    await alertService.markAsRead(
      alert.id,
    );

    loadAlerts();

    loadUnreadCount();

  },

  child: notificationCard(

    icon: getIcon(
      alert.alertType,
    ),

    title: alert.alertType,

    subtitle: alert.message,

    time: alert.createdTime,

    color: getColor(
      alert.priority,
    ),

    isRead: alert.isRead,

  ),
);
            },
          ),

  );

}

  @override
void dispose() {

  timer?.cancel();

  super.dispose();

}

  IconData getIcon(String type) {

  switch(type){

    case "DELAY":
      return Icons.warning;

    case "ROUTE_DEVIATION":
      return Icons.route;

    case "APPROACHING_DESTINATION":
      return Icons.access_time_filled;

    case "DESTINATION_REACHED":
      return Icons.flag_circle;

    default:
      return Icons.notifications;
  }

}

  Color getColor(String? priority){

  switch(priority){

    case "HIGH":
      return Colors.red;

    case "MEDIUM":
      return Colors.orange;

    case "LOW":
      return Colors.green;

    default:
      return Colors.blue;
  }

}

  Widget notificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
    required bool isRead,
  }) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: isRead  ? Colors.grey.shade100 : Colors.white,

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
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Expanded(
                      child: Text(
                        title,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,

                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(

                      time.length >= 16 ? time.substring(11,16) : time,

                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.black45,
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