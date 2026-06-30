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

  Future<void> deleteAllAlerts() async {
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Calling API...")),
    );

    await alertService.deleteAllAlerts("147C");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("API Success")),
    );

    await loadAlerts();
    await loadUnreadCount();
  } catch (e, stackTrace) {
  debugPrint("DELETE ERROR: $e");
  debugPrintStack(stackTrace: stackTrace);

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.toString()),
    ),
  );
}
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
    : Column(
        children: [

          /// LIST OR EMPTY STATE
          Expanded(
            child: alerts.isEmpty
                ? buildEmptyState()
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
          ),

          /// DELETE BUTTON
          if (alerts.isNotEmpty)
  Padding(
    padding: const EdgeInsets.fromLTRB(
      16,
      8,
      16,
      16,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: deleteAllAlerts,
        icon: const Icon(Icons.delete),
        label: const Text(
          "Delete All Alerts",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    ),
  ),
// Container(
//   color: Colors.yellow,
//   padding: const EdgeInsets.all(16),
//   child: SizedBox(
//     width: double.infinity,
//     height: 60,
//     child: ElevatedButton(
//       onPressed: () {
//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(
//       content: Text("Button Clicked"),
//     ),
//   );
// },
//       child: const Text("TEST BUTTON"),
//     ),
//   ),
// ),
        ],
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
  Widget buildEmptyState() {

  return Center(

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Icon(
          Icons.notifications_none_outlined,
          size: 110,
          color: Colors.grey.shade400,
        ),

        const SizedBox(height: 20),

        const Text(

          "No Alerts Found",

          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B5D1E),
          ),
        ),

        const SizedBox(height: 12),

        Text(

          "You don't have any alerts at the moment.",

          textAlign: TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}
}