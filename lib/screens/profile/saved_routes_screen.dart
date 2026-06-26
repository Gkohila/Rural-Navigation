import 'package:flutter/material.dart';

import '../../models/saved_route_model.dart';
import '../../services/saved_route_api_service.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Saved Routes"),
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

            return const Center(
              child: Text(
                "No Saved Routes",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );

          }

          final routes =
              snapshot.data!;

          return ListView.builder(

            itemCount: routes.length,

            itemBuilder: (context, index) {

              final route =
                  routes[index];

              return Card(

                margin:
                    const EdgeInsets.all(12),

                child: ListTile(

                  leading: const Icon(
                    Icons.directions_bus,
                    color: Colors.green,
                  ),

                  title: Text(
                    route.vehicleNumber,
                  ),

                  subtitle: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        "${route.source} → ${route.destination}",
                      ),

                      Text(
                        "₹${route.fare}",
                      ),

                      Text(
                        "${route.duration} mins",
                      ),

                      Text(
                        "${route.departureTime} → ${route.arrivalTime}",
                      ),

                    ],

                  ),

                  trailing: IconButton(

                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),

                    onPressed: () async {

                      await SavedRouteApiService
                          .deleteRoute(route.id!);

                      setState(() {

                        loadRoutes();

                      });

                    },

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