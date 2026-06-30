import 'package:flutter/material.dart';
import 'alert_details_screen.dart';

import 'package:smartnav/widgets/home/bottom_navbar.dart';

import 'package:smartnav/screens/profile/profile_screen.dart';

import 'package:smartnav/features/maps/screens/route_search_screen.dart';
import 'package:smartnav/models/alert_model.dart';
import 'package:smartnav/services/alert_service.dart';
class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() =>
      _AlertsScreenState();
}

class _AlertsScreenState
    extends State<AlertsScreen> {

  final AlertService alertService =
      AlertService();

  List<AlertModel> alerts = [];

  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadAlerts();
  }

  Future<void> loadAlerts() async {

  final result = await alertService.getAlerts("TN72 N145");

  print(result);

  print("Length = ${result.length}");

  setState(() {
    alerts = result;
  });

  unreadCount =
      await alertService.getUnreadCount("TN72 N145");

  print("Unread = $unreadCount");
}

Future<void> deleteAllAlerts() async {
  try {
    await alertService.deleteAllAlerts("TN72 N145");

    setState(() {
      alerts.clear();
      unreadCount = 0;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All alerts deleted successfully."),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
      ),
    );
  }
}

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
        
  child: Column(
    children: [

      /// HEADER
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        child: Row(
          children: [

            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new),
            ),

            const Expanded(
              child: Center(
                child: Text(
                  "Alerts",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B5D1E),
                  ),
                ),
              ),
            ),

            Stack(
              children: [

                const Icon(
                  Icons.notifications_none,
                  color: Color(0xFF0B5D1E),
                  size: 30,
                ),

                if (unreadCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 10),
          ],
        ),
      ),

      /// ALERT LIST / EMPTY STATE
      Expanded(
        child: alerts.isEmpty
            ? buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                itemCount: alerts.length,
                itemBuilder: (context, index) {

                  final alert = alerts[index];

                  Color color = Colors.green;

                  if (alert.priority == "HIGH") {
                    color = Colors.red;
                  } else if (alert.priority == "MEDIUM") {
                    color = Colors.orange;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: GestureDetector(
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
                        color: color,
                        title: alert.alertType,
                        subtitle: alert.message,
                        delay: alert.vehicleNumber,
                        location: alert.createdTime,
                        priority: alert.priority,
                      ),
                    ),
                  );
                },
              ),
      ),

      /// DELETE BUTTON
      Padding(
        padding: const EdgeInsets.fromLTRB(
          18,
          10,
          18,
          18,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton.icon(
            onPressed: deleteAllAlerts,
            icon: const Icon(Icons.delete),
            label: const Text(
              "Delete All Alerts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),
    ],
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
  Widget buildEmptyState() {

  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
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
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B5D1E),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "You don't have any alerts at the moment.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
}