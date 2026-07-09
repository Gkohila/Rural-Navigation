import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartnav/features/maps/models/direction_data.dart';
import 'package:smartnav/features/maps/widgets/route_map_widget.dart';

import 'dart:async';

class LiveNavigationScreen extends StatefulWidget {
  final DirectionData? directionData;
  final String source;
  final String destination;
  final int transportIndex;

  const LiveNavigationScreen({
    super.key,
    required this.directionData,
    required this.source,
    required this.destination,
    required this.transportIndex,
  });

  @override
  State<LiveNavigationScreen> createState() => _LiveNavigationScreenState();
}

class _LiveNavigationScreenState extends State<LiveNavigationScreen> {
  GoogleMapController? mapController;

  late LatLng startLocation;
  late LatLng destinationLocation;

  Set<Marker> markers = {};
  late BitmapDescriptor vehicleIcon;

  Timer? _busTimer;
  LatLng? _busPosition;
  int _busIndex = 0;

  Set<Marker> busMarkers = {};

  @override
  void initState() {
    super.initState();

    if (widget.directionData != null &&
        widget.directionData!.polyline.isNotEmpty) {
      final points = widget.directionData!.polyline;

      startLocation = LatLng(
        (points.first[1] as num).toDouble(),
        (points.first[0] as num).toDouble(),
      );

      destinationLocation = LatLng(
        (points.last[1] as num).toDouble(),
        (points.last[0] as num).toDouble(),
      );
    } else {
      startLocation = const LatLng(8.9598, 77.3152);
      destinationLocation = const LatLng(8.7139, 77.7567);
    }

    markers = {
      Marker(
        markerId: const MarkerId("start"),
        position: startLocation,
        infoWindow: InfoWindow(title: widget.source),
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: destinationLocation,
        infoWindow: InfoWindow(title: widget.destination),
      ),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadVehicleIcon();
    });
  }

  List<LatLng> getPolylinePoints() {
    if (widget.directionData == null) {
      return [];
    }

    return widget.directionData!.polyline
        .map<LatLng>(
          (p) => LatLng((p[1] as num).toDouble(), (p[0] as num).toDouble()),
        )
        .toList();
  }

  Future<void> loadVehicleIcon() async {
    String assetPath = "assets/markers/bus.png";
    print("Loading asset: $assetPath");
    switch (widget.transportIndex) {
      case 0:
        assetPath = "assets/markers/car.png";
        break;

      case 1:
        assetPath = "assets/markers/bike.png";
        break;

      case 2:
        assetPath = "assets/markers/bus.png";
        break;

      case 3:
        assetPath = "assets/markers/walk.png";
        break;
    }

    vehicleIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      assetPath,
    );
    print("Vehicle icon loaded");
    if (mounted) {
      startBusSimulation();
    }
  }

  void startBusSimulation() {
    final points = getPolylinePoints();

    if (points.isEmpty) return;

    _busPosition = points.first;

    busMarkers = {
      Marker(
        markerId: const MarkerId("bus"),
        position: _busPosition!,
        icon: vehicleIcon,
        infoWindow: const InfoWindow(title: "SmartNav Bus"),
      ),
    };

    _busTimer?.cancel();

    _busTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_busIndex >= points.length) {
        timer.cancel();
        return;
      }

      setState(() {
        _busPosition = points[_busIndex];

        busMarkers = {
          Marker(
            markerId: const MarkerId("bus"),
            position: _busPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            infoWindow: const InfoWindow(title: "SmartNav Bus"),
          ),
        };

        _busIndex++;
      });
    });
  }

  String get distance {
    if (widget.directionData == null) return "--";

    final distanceKm = double.tryParse(widget.directionData!.distance) ?? 0.0;

    return "${distanceKm.toStringAsFixed(1)} km";
  }

  String get eta {
    if (widget.directionData == null) return "--";

    final durationSeconds =
        double.tryParse(widget.directionData!.duration) ?? 0.0;

    final mins = (durationSeconds / 60).round();

    return "$mins min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// MAP (UNCHANGED)
          RouteMapWidget(
            source: startLocation,
            destination: destinationLocation,
            polylinePoints: getPolylinePoints(),
            extraMarkers: busMarkers,
          ),

          /// TOP BAR
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Live Navigation",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.destination,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 18,
                      color: Colors.black12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffF7F8FA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "ETA",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  eta,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffF7F8FA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  distance,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Divider(),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xffFDEDED),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Destination",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.destination.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.navigation),
                        label: const Text(
                          "End Trip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _busTimer?.cancel();
    super.dispose();
  }
}
