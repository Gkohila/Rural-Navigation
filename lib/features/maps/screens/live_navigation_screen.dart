import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartnav/features/maps/models/direction_data.dart';
import 'package:smartnav/features/maps/widgets/route_map_widget.dart';

class LiveNavigationScreen extends StatefulWidget {
  final DirectionData? directionData;
  final String source;
  final String destination;

  const LiveNavigationScreen({
    super.key,
    required this.directionData,
    required this.source,
    required this.destination,
  });

  @override
  State<LiveNavigationScreen> createState() => _LiveNavigationScreenState();
}

class _LiveNavigationScreenState extends State<LiveNavigationScreen> {
  GoogleMapController? mapController;

  late LatLng startLocation;
  late LatLng destinationLocation;

  Set<Marker> markers = {};

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
      // Fallback
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouteMapWidget(
        source: startLocation,
        destination: destinationLocation,
        polylinePoints: getPolylinePoints(),
      ),
    );
  }
}
