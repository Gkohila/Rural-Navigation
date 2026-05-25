import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FreeLiveMap extends StatelessWidget {
  const FreeLiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(8.7139, 77.7567), // Tenkasi
        initialZoom: 13,
      ),

      children: [

        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

          userAgentPackageName: 'com.smartnav.app',
        ),

        MarkerLayer(
          markers: [
            Marker(
              point: const LatLng(8.7139, 77.7567),

              width: 40,
              height: 40,

              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}