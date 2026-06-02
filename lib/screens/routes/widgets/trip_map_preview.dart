import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripMapPreview extends StatefulWidget {
  const TripMapPreview({super.key});

  @override
  State<TripMapPreview> createState() => _TripMapPreviewState();
}

class _TripMapPreviewState extends State<TripMapPreview> {
  late GoogleMapController mapController;

  final LatLng tenkasi = const LatLng(8.9598, 77.3152);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: tenkasi,
          zoom: 14,
        ),

        myLocationEnabled: true,
        myLocationButtonEnabled: true,

        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,

        zoomControlsEnabled: false,
        mapToolbarEnabled: false,

        markers: {
          Marker(
            markerId: const MarkerId('tenkasi'),
            position: tenkasi,
            infoWindow: const InfoWindow(
              title: 'Tenkasi Route',
            ),
          ),
        },

        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: const [
              LatLng(8.9598, 77.3152),
              LatLng(8.9700, 77.3300),
            ],
          ),
        },

        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}