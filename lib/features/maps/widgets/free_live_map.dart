import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FreeLiveMap extends StatelessWidget {
  const FreeLiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(

      options: const MapOptions(

        initialCenter: LatLng(
          8.7139,
          77.7567,
        ),

        initialZoom: 13,

        minZoom: 5,
        maxZoom: 18,

        interactionOptions:
            InteractionOptions(

          flags:

              /// MAP MOVE
              InteractiveFlag.drag |

              /// PINCH ZOOM
              InteractiveFlag.pinchZoom |

              /// DOUBLE TAP ZOOM
              InteractiveFlag.doubleTapZoom |

              /// FLING
              InteractiveFlag.flingAnimation |

              /// INERTIA
              InteractiveFlag.scrollWheelZoom,
        ),
      ),

      children: [

        /// OPEN STREET MAP TILES
        TileLayer(

          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

          userAgentPackageName:
              'com.smartnav.app',
        ),

        /// LIVE MARKER
        MarkerLayer(

          markers: [

            Marker(

              point: const LatLng(
                8.7139,
                77.7567,
              ),

              width: 50,
              height: 50,

              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}