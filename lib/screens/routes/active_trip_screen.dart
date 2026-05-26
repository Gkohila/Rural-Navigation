import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../theme/app_colors.dart';
import '../../widgets/home/bottom_navbar.dart';

import 'trip_planner_data.dart';
import 'last_mile_screen.dart';
import 'widgets/transport_chip.dart';
import 'widgets/trip_timeline.dart';
import 'widgets/warning_card.dart';

class ActiveTripScreen extends StatefulWidget {
  const ActiveTripScreen({super.key});

  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {

  int selectedTransport = 0;

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(10.0104, 77.4768),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        bottom: false,

        child: Stack(
          children: [

            // GOOGLE MAP
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: true,
              ),
            ),

            // APP BAR
            Positioned(
              top: 0,
              left: 0,
              right: 0,

              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                color: Colors.white,

                child: Row(
                  children: [

                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(Icons.arrow_back),
                    ),

                    Text(
                      'Trip Planner',

                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            ),

            // DRAGGABLE SHEET
            DraggableScrollableSheet(
              initialChildSize: 0.60,
              minChildSize: 0.38,
              maxChildSize: 0.95,

              builder: (context, scrollController) {

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),

                  child: SingleChildScrollView(
                    controller: scrollController,

                    child: Padding(
                      padding: const EdgeInsets.all(18),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Center(
                            child: Container(
                              width: 50,
                              height: 5,

                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // TOP OPTIONS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),

                                child: Row(
                                  children: const [
                                    Icon(Icons.tune),
                                    SizedBox(width: 10),
                                    Text(
                                      'Other trip\noptions',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.all(16),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),

                                child: const Icon(Icons.layers),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // TRANSPORT CHIPS
                          Row(
                            children: [

                              TransportChip(
                                label: 'Lion Travels',
                                isSelected: true,
                                onTap: () {},
                                icon: Icons.directions_bus,
                              ),

                              const SizedBox(width: 10),

                              TransportChip(
                                label: 'Local',
                                isSelected: false,
                                onTap: () {},
                                icon: Icons.train,
                              ),

                              const Spacer(),

                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade100,
                                ),

                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // WARNING CARDS
                          const WarningCard(
                            icon: Icons.warning_amber_rounded,
                            message:
                                'Use caution — wheelchair-accessible directions may not always reflect real-world conditions.',
                          ),

                          const SizedBox(height: 14),

                          const WarningCard(
                            icon: Icons.info,
                            message:
                                'We don’t have the most recent timetables for this area.',
                          ),

                          const SizedBox(height: 28),

                          // TIMELINE
                          TripTimeline(
                            stops: [
                              TimelineStopData(
                                type: TimelineStopType.origin,
                                title: 'Your location',
                                time: '9:14 pm',
                              ),

                              TimelineStopData(
                                type: TimelineStopType.walk,
                                title: 'Walk 11 min (750 m)',
                              ),

                              TimelineStopData(
                                type: TimelineStopType.busStand,
                                title: 'Theni Bus Stand',
                                subtitle: 'Platform 4 · Bay A',
                                time: '9:25 pm',
                              ),

                              TimelineStopData(
                                type: TimelineStopType.intermediate,
                                title: 'Lion Travels',
                                subtitle:
                                    'Chennai - Theni • AC Sleeper (2+1)',
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          // ACTION BUTTONS
                          Row(
                            children: [

                              Expanded(
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),

                                  onPressed: () {},

                                  icon: const Icon(Icons.stop),

                                  label: const Text('End'),
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),

                                  onPressed: () {},

                                  icon: const Icon(Icons.bookmark_border),

                                  label: const Text('Save'),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // BOTTOM NAVBAR
            Align(
              alignment: Alignment.bottomCenter,

              child: HomeBottomNavbar(
                selectedItem: HomeNavItem.routes,
                onItemSelected: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}