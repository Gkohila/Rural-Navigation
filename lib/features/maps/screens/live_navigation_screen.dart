import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartnav/features/maps/models/direction_data.dart';

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
  State<LiveNavigationScreen> createState() =>
      _LiveNavigationScreenState();
}

class _LiveNavigationScreenState
    extends State<LiveNavigationScreen> {

  GoogleMapController? mapController;

  late LatLng startLocation;
  late LatLng destinationLocation;

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    /// Temporary coordinates
    /// Next step we'll make these dynamic using DirectionData
    startLocation = const LatLng(
      8.9598,
      77.3152,
    );

    destinationLocation = const LatLng(
      8.7139,
      77.7567,
    );

    markers = {

      Marker(
        markerId: const MarkerId("start"),
        position: startLocation,
        infoWindow: InfoWindow(
          title: widget.source,
        ),
      ),

      Marker(
        markerId: const MarkerId("destination"),
        position: destinationLocation,
        infoWindow: InfoWindow(
          title: widget.destination,
        ),
      ),

    };
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Live Navigation"),
      ),

      body: GoogleMap(

        initialCameraPosition: CameraPosition(
          target: startLocation,
          zoom: 11,
        ),

        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        zoomControlsEnabled: false,

        markers: markers,

        onMapCreated: (controller) {
          mapController = controller;
        },

      ),
    );
  }
}