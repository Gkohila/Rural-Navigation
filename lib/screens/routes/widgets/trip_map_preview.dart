import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class TripMapPreview extends StatefulWidget {

  final String vehicleNumber;

  const TripMapPreview({
    super.key,
    required this.vehicleNumber,
  });

  @override
  State<TripMapPreview> createState() => _TripMapPreviewState();
}

class _TripMapPreviewState extends State<TripMapPreview> {
  GoogleMapController? mapController;

  LatLng busLocation = const LatLng(8.9598, 77.3152);
  Timer? timer;

  @override
void initState() {
  super.initState();

  loadBusLocation();
  timer = Timer.periodic(
    const Duration(seconds: 5),
    (_) {
      loadBusLocation();
    },
  );
}

Future<void> loadBusLocation() async {

  final response = await http.get(

    Uri.parse(
      "http://localhost:8081/api/locations/latest/${widget.vehicleNumber}",
    ),

  );

  print(response.body);

  if (response.statusCode == 200) {
    if (!mounted) return;

    final data = jsonDecode(response.body);

    setState(() {

      busLocation = LatLng(
        (data['latitude'] as num).toDouble(),
        (data['longitude'] as num).toDouble(),
      );
    });
    print(busLocation.latitude);
    print(busLocation.longitude);
    print(busLocation);

    mapController?.animateCamera(

      CameraUpdate.newLatLng(busLocation),

    );
  }
}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: busLocation,
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
    markerId: const MarkerId('bus'),
    position: busLocation,

    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),

    infoWindow: InfoWindow(
      title: widget.vehicleNumber,
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
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              busLocation,
              14,
            ),
          );
        },
      ),
    );
  }
  @override
  void dispose() {

    timer?.cancel();

    super.dispose();

  }
}