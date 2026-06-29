import 'package:flutter/material.dart';

import '../../features/maps/screens/route_search_screen.dart';
import '../../models/saved_route_model.dart';
import '../../services/saved_route_api_service.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

class SavedRoutesScreen extends StatefulWidget {
  const SavedRoutesScreen({super.key});

  @override
  State<SavedRoutesScreen> createState() =>
      _SavedRoutesScreenState();
}

class _SavedRoutesScreenState
    extends State<SavedRoutesScreen> {
  late Future<List<SavedRouteModel>> routesFuture;

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  void loadRoutes() {
    routesFuture =
        SavedRouteApiService.getSavedRoutes();
  }

  Future<void> deleteRoute(int id) async {

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Remove Route"),
        content: const Text(
          "Do you want to remove this saved route?",
        ),
        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Remove"),
          ),

        ],
      );
    },
  );

  if (confirm != true) return;

  final success =
      await SavedRouteApiService.deleteRoute(id);

  if (success) {

    setState(() {
      loadRoutes();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Route removed"),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SmartNavColors.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: SmartNavColors.surface,
        title: Text(
          "Saved Routes",
          style: SmartNavTextStyles.headlineMdBold.copyWith(
  color: const Color(0xFF0B5D1E),
),
        ),
      ),

      body: FutureBuilder<List<SavedRouteModel>>(
        future: routesFuture,

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [

                  Icon(
  Icons.bookmark_border_rounded,
  size: 70,
  color: const Color(0xFF0B5D1E),
),

                  const SizedBox(height: 16),

                  Text(
  "No Saved Routes",
  style: SmartNavTextStyles.headlineMd.copyWith(
    color: const Color(0xFF0B5D1E),
    fontWeight: FontWeight.w700,
  ),
),

                  const SizedBox(height: 6),

                  Text(
  "Save your favourite routes\nfor quick access.",
  textAlign: TextAlign.center,
  style: SmartNavTextStyles.bodyMd.copyWith(
    color: Colors.black54,
  ),
),

                ],
              ),
            );
          }

          final routes = snapshot.data!;

          return ListView.builder(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            itemCount: routes.length,

            itemBuilder: (context, index) {

              final route = routes[index];
              return Container(
  margin: const EdgeInsets.only(bottom: 12),

  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: SmartNavColors.outlineVariant,
    ),
    boxShadow: SmartNavElevation.card,
  ),

  child: Material(
    color: Colors.transparent,

    child: InkWell(
      borderRadius: BorderRadius.circular(14),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
           builder: (_) => RouteSearchScreen(
  initialSource: route.source,
  initialDestination: route.destination,
  initialTransportMode: route.transportMode,
   fromSavedRoute: true,
),
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Container(
              width: 36,
              height: 36,

              decoration: BoxDecoration(
                color: SmartNavColors.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(10),
              ),

              child: const Icon(
                Icons.directions_bus_rounded,
                size: 18,
                color: SmartNavColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    route.vehicleNumber,
                    style: SmartNavTextStyles.bodyLg.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    "${route.source} → ${route.destination}",
                    style: SmartNavTextStyles.bodyMd.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [

                      const Icon(
                        Icons.schedule_outlined,
                        size: 14,
                        color: SmartNavColors.onSurfaceVariant,
                      ),

                      const SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          "${route.departureTime} • ${route.duration} min",
                          style: SmartNavTextStyles.labelSm,
                        ),
                      ),

                      Text(
                        "₹${route.fare}",
                        style: SmartNavTextStyles.titleSm.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),

           Column(
  children: [

    IconButton(
      icon: const Icon(
        Icons.delete_outline_rounded,
        color: Colors.red,
      ),
      onPressed: () {
        deleteRoute(route.id!);
      },
    ),

   

  ],
),
          ],
        ),
      ),
    ),
  ),
);
            },
          );
        },
      ),
    );
  }
}