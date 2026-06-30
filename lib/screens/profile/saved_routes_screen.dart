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

    final routes = await routesFuture;

    if (routes.isEmpty) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: SmartNavColors.primary,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          content: const Row(
            children: [

              Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  "No saved routes to remove.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      );

      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {

        return Dialog(

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(24),
          ),

          child: Padding(
            padding:
                const EdgeInsets.all(24),

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                CircleAvatar(
                  radius: 32,
                  backgroundColor:
                      SmartNavColors.primary
                          .withOpacity(.10),

                  child: const Icon(
                    Icons.delete_sweep_rounded,
                    color:
                        SmartNavColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
  "Delete All Saved Routes",
                  textAlign:
                      TextAlign.center,
                  style:
                      SmartNavTextStyles
                          .headlineMdBold,
                ),

                const SizedBox(height: 10),

                Text(
                  "This action will permanently remove all your saved routes.\nThis cannot be undone.",
                  textAlign:
                      TextAlign.center,
                  style:
                      SmartNavTextStyles
                          .bodyMd
                          .copyWith(
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: [

                    Expanded(
                      child:
                          OutlinedButton(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              false);
                        },

                        style:
                            OutlinedButton
                                .styleFrom(
                          side: BorderSide(
                            color:
                                SmartNavColors
                                    .primary,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        14),
                          ),

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 14,
                          ),
                        ),

                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color:
                                SmartNavColors
                                    .primary,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child:
                          ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                              context,
                              true);
                        },

                        icon: const Icon(
                          Icons
                              .delete_outline_rounded,
                          size: 20,
                        ),

                        label: const Text(
  "Delete All",
  style: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
),

                       style: ElevatedButton.styleFrom(
  backgroundColor: Colors.red.shade700,
  foregroundColor: Colors.white,
  elevation: 0,

  minimumSize: const Size(double.infinity, 52),

  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),

  padding: const EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 12,
  ),
),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirm != true) return;

    final success =
        await SavedRouteApiService
            .deleteAllRoutes();

    if (!mounted) return;

    if (success) {

      setState(() {
        loadRoutes();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              SmartNavColors.primary,
          margin:
              const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          content: const Row(
            children: [

              Icon(
                Icons.delete_sweep_rounded,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  "All saved routes removed successfully.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
  }
    Future<void> deleteRoute(int id) async {

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20),
          ),
          title: const Text(
            "Remove Route",
          ),
          content: const Text(
            "Do you want to remove this saved route?",
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    SmartNavColors.primary,
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                "Remove",
              ),
            ),

          ],
        );
      },
    );

    if (confirm != true) return;

    final success =
        await SavedRouteApiService
            .deleteRoute(id);

    if (success) {

      setState(() {
        loadRoutes();
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              SmartNavColors.primary,
          margin:
              const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          content: const Row(
            children: [

              Icon(
                Icons.check_circle_rounded,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  "Route removed successfully.",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          SmartNavColors.background,

      appBar: AppBar(
  elevation: 1,
  surfaceTintColor: Colors.transparent,
  backgroundColor: SmartNavColors.surface,

        title: Text(
          "Saved Routes",
          style: SmartNavTextStyles
              .headlineMdBold
              .copyWith(
            color:
                const Color(0xFF0B5D1E),
          ),
        ),

        actions: [

  Padding(
    padding: const EdgeInsets.only(right: 8),
    child: IconButton(
      tooltip: "Delete All",
      onPressed: deleteAllRoutes,

      icon: Container(
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: Colors.red.withOpacity(.12),
          borderRadius:
              BorderRadius.circular(12),
        ),

        child: const Icon(
          Icons.delete_sweep_rounded,
          color: Colors.red,
          size: 20,
        ),
      ),
    ),
  ),

],
      ),

      body:
          FutureBuilder<List<SavedRouteModel>>(
        future: routesFuture,
        builder:
            (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error
                    .toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [

                  const Icon(
                    Icons
                        .bookmark_border_rounded,
                    size: 70,
                    color: Color(
                        0xFF0B5D1E),
                  ),

                  const SizedBox(
                      height: 16),

                  Text(
                    "No Saved Routes",
                    style:
                        SmartNavTextStyles
                            .headlineMd
                            .copyWith(
                      color:
                          const Color(
                              0xFF0B5D1E),
                      fontWeight:
                          FontWeight
                              .w700,
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Text(
                    "Save your favourite routes\nfor quick access.",
                    textAlign:
                        TextAlign.center,
                    style:
                        SmartNavTextStyles
                            .bodyMd
                            .copyWith(
                      color:
                          Colors.black54,
                    ),
                  ),

                ],
              ),
            );
          }

          final routes =
              snapshot.data!;

          return ListView.builder(
            padding:
                const EdgeInsets
                    .symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            itemCount:
                routes.length,
            itemBuilder:
                (context, index) {

              final route =
                  routes[index];

              return Container(
                margin:
                    const EdgeInsets
                        .only(
                            bottom:
                                12),
                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius
                          .circular(
                              14),
                  border:
                      Border.all(
                    color:
                        SmartNavColors
                            .outlineVariant,
                  ),
                  boxShadow:
                      SmartNavElevation
                          .card,
                ),

                child: Material(
                  color: Colors
                      .transparent,

                  child: InkWell(
                    borderRadius:
                        BorderRadius
                            .circular(
                                14),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  RouteSearchScreen(
                            initialSource:
                                route
                                    .source,
                            initialDestination:
                                route
                                    .destination,
                            initialTransportMode:
                                route
                                    .transportMode,
                            fromSavedRoute:
                                true,
                          ),
                        ),
                      );
                    },

                    child: Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal:
                            14,
                        vertical:
                            12,
                      ),

                      child: Row(
                        children: [

                          Container(
                            width: 40,
                            height:
                                40,
                            decoration:
                                BoxDecoration(
                              color:
                                  SmartNavColors
                                      .primary
                                      .withOpacity(
                                          .08),
                              borderRadius:
                                  BorderRadius.circular(
                                      10),
                            ),
                            child:
                                Icon(
                              getTransportIcon(
                                  route.transportMode),
                              color:
                                  SmartNavColors.primary,
                            ),
                          ),

                          const SizedBox(
                              width:
                                  12),

                          Expanded(
                            child:
                                Text(
                              "${route.source} → ${route.destination}",
                              style:
                                  SmartNavTextStyles.bodyLg.copyWith(
                                fontWeight:
                                    FontWeight.w700,
                              ),
                            ),
                          ),

                          Padding(
  padding: const EdgeInsets.only(right: 4),
  child: IconButton(
    onPressed: () {
      deleteRoute(route.id!);
    },
    icon: Icon(
      Icons.delete_outline_rounded,
      color: Colors.red.shade600,
      size: 22,
    ),
  ),
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