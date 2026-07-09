import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapWidget extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  final List<LatLng> polylinePoints;

  /// Optional markers (example: moving bus marker)
  final Set<Marker> extraMarkers;

  const RouteMapWidget({
    super.key,
    required this.source,
    required this.destination,
    required this.polylinePoints,
    this.extraMarkers = const {},
  });

  @override
  State<RouteMapWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  GoogleMapController? mapController;

  @override
  void didUpdateWidget(covariant RouteMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.source != widget.source ||
        oldWidget.destination != widget.destination ||
        oldWidget.polylinePoints.length != widget.polylinePoints.length) {
      _moveCameraToRoute();
    }
  }

  Future<void> _moveCameraToRoute() async {
    if (mapController == null) return;

    final List<LatLng> points = widget.polylinePoints.isNotEmpty
        ? widget.polylinePoints
        : [widget.source, widget.destination];

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    await mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.source,
        zoom: 13,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,

      markers: {
        Marker(
          markerId: const MarkerId("source"),
          position: widget.source,
          infoWindow: const InfoWindow(title: "Source"),
        ),

        Marker(
          markerId: const MarkerId("destination"),
          position: widget.destination,
          infoWindow: const InfoWindow(title: "Destination"),
        ),

        // Additional markers (bus, etc.)
        ...widget.extraMarkers,
      },

      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: widget.polylinePoints,
          color: Colors.blue,
          width: 6,
        ),
      },

      onMapCreated: (controller) async {
        mapController = controller;
        await _moveCameraToRoute();
      },
    );
  }
}