import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveGoogleMap extends StatefulWidget {
  const LiveGoogleMap({super.key});

  @override
  State<LiveGoogleMap> createState() =>
      _LiveGoogleMapState();
}

class _LiveGoogleMapState
    extends State<LiveGoogleMap> {

  GoogleMapController? _controller;

  static const CameraPosition _initialPosition =
      CameraPosition(
    target: LatLng(8.9598, 77.3152),
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {

    return GoogleMap(

      initialCameraPosition:
          _initialPosition,

      mapType: MapType.normal,

      myLocationEnabled: true,

      myLocationButtonEnabled: false,

      zoomControlsEnabled: false,

      compassEnabled: true,

      onMapCreated:
          (GoogleMapController controller) {

        _controller = controller;
      },

      markers: {

        const Marker(
          markerId: MarkerId('start'),

          position: LatLng(
            8.9598,
            77.3152,
          ),

          infoWindow: InfoWindow(
            title: 'Tenkasi',
          ),
        ),

        const Marker(
          markerId: MarkerId('destination'),

          position: LatLng(
            8.9342,
            77.2778,
          ),

          infoWindow: InfoWindow(
            title: 'Courtallam',
          ),
        ),
      },
    );
  }
}