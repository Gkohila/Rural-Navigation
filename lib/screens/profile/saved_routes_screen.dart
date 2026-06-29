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
  IconData getTransportIcon(String mode) {
  switch (mode.toLowerCase()) {
    case "bus":
      return Icons.directions_bus_rounded;
    case "train":
      return Icons.train_rounded;
    case "auto":
      return Icons.electric_rickshaw_rounded;
    case "walking":
      return Icons.directions_walk_rounded;
    default:
      return Icons.route_rounded;
  }
}

  @override
  void initState() {
    super.initState();
    loadRoutes();
  }

  void loadRoutes() {
    routesFuture =
        SavedRouteApiService.getSavedRoutes();
  }

  Future<void> deleteAllRoutes() async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Remove All Routes"),
      content: const Text(
        "Do you want to remove all saved routes?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Remove All"),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  final success =
      await SavedRouteApiService.deleteAllRoutes();

  if (success) {
    setState(() {
      loadRoutes();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All routes removed"),
      ),
    );
  }
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

  actions: [

    PopupMenuButton<String>(

      onSelected: (value) {

        if (value == "delete_all") {

          deleteAllRoutes();

        }

      },

      itemBuilder: (context) => [

        const PopupMenuItem(

          value: "delete_all",

          child: Text("Delete All"),

        ),

      ],

    ),

  ],
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
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Container(
              width: 40,
              height: 40,

              decoration: BoxDecoration(
                color: SmartNavColors.primary.withOpacity(.08),
                borderRadius: BorderRadius.circular(10),
              ),

              child: Icon(
  getTransportIcon(route.transportMode),
  size: 20,
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
  "${route.source}  →  ${route.destination}",
  style: SmartNavTextStyles.bodyLg.copyWith(
    fontWeight: FontWeight.w700,
  ),
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