import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteMapWidget extends StatefulWidget {
  final LatLng source;
  final LatLng destination;
  final List<LatLng> polylinePoints;

  const RouteMapWidget({
    super.key,
    required this.source,
    required this.destination,
    required this.polylinePoints,
  });

  @override
  State<RouteMapWidget> createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  GoogleMapController? mapController;

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
          infoWindow: const InfoWindow(
            title: "Source",
          ),
        ),

        Marker(
          markerId: const MarkerId("destination"),
          position: widget.destination,
          infoWindow: const InfoWindow(title: "Destination",),
        ),
      },

      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          width: 5,
          color: Colors.blue,
          points: getPolylinePoints(),
        ),
      },

onMapCreated: (controller) async {
  mapController = controller;

  final bounds = LatLngBounds(
    southwest: LatLng(
      widget.source.latitude < widget.destination.latitude
          ? widget.source.latitude
          : widget.destination.latitude,
      widget.source.longitude < widget.destination.longitude
          ? widget.source.longitude
          : widget.destination.longitude,
    ),
    northeast: LatLng(
      widget.source.latitude > widget.destination.latitude
          ? widget.source.latitude
          : widget.destination.latitude,
      widget.source.longitude > widget.destination.longitude
          ? widget.source.longitude
          : widget.destination.longitude,
    ),
  );

  await controller.animateCamera(
    CameraUpdate.newLatLngBounds(
      bounds,
      80,
    ),
  );
},
    );
  }

  List<LatLng> getPolylinePoints() {
    return widget.polylinePoints;
  }
}