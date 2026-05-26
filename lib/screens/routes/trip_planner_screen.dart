import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/animations/interactive_scale.dart';
import '../../widgets/home/bottom_navbar.dart';

import 'trip_planner_data.dart';
import 'active_trip_screen.dart';

import 'widgets/planner_action_buttons.dart';
import 'widgets/transport_chip.dart';
import 'widgets/trip_map_preview.dart';
import 'widgets/trip_timeline.dart';
import 'widgets/warning_card.dart';

/// Trip Planner — static route timeline UI (bus_route_detailed_timeline design).
class TripPlannerScreen extends StatefulWidget {
  final String transportName;
  final String routeNumber;
  final String departureTime;
  final String arrivalTime;

  const TripPlannerScreen({
    super.key,
    required this.transportName,
    required this.routeNumber,
    required this.departureTime,
    required this.arrivalTime,
  });

  @override
  State<TripPlannerScreen> createState() => _TripPlannerScreenState();
}

class _TripPlannerScreenState extends State<TripPlannerScreen> {
  int _selectedTransport = 0;
  HomeNavItem _navItem = HomeNavItem.routes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        bottom: false,

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppColors.maxContentWidth,
            ),

            child: Stack(
              children: [

                // FULL GOOGLE MAP
                Positioned.fill(
                  child: TripMapPreview(),
                ),

                // TOP APP BAR
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _TripPlannerAppBar(),
                ),

                // DRAGGABLE WHITE SHEET
                DraggableScrollableSheet(
                  initialChildSize: 0.55,
                  minChildSize: 0.30,
                  maxChildSize: 0.95,

                  builder: (context, scrollController) {

                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: SingleChildScrollView(
                        controller: scrollController,

                        child: Column(
                          children: [

                            const SizedBox(height: 12),

                            // DRAG HANDLE
                            Center(
                              child: Container(
                                width: 50,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            _RouteSheet(
                              selectedTransport: _selectedTransport,

                              onTransportSelected: (i) =>
                                  setState(() => _selectedTransport = i),

                              transportName: widget.transportName,
                              routeNumber: widget.routeNumber,
                              departureTime: widget.departureTime,
                            ),

                            const SizedBox(height: 160),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // FIXED BOTTOM SECTION
                Align(
                  alignment: Alignment.bottomCenter,

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      PlannerActionButtons(
                        duration: TripPlannerData.durationSummary,
                        arrival: TripPlannerData.arrivalSummary,

                        onStart: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ActiveTripScreen(),
                            ),
                          );
                        },

                        onSave: () {},

                        animateDelayMs: 200,
                      ),

                      HomeBottomNavbar(
                        selectedItem: _navItem,
                        onItemSelected: _onNavSelected,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }

  void _onNavSelected(HomeNavItem item) {

    if (item == HomeNavItem.home) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    if (item == HomeNavItem.routes) return;

    setState(() => _navItem = item);
  }
}

/// Top bar: back, title, overflow menu.
class _TripPlannerAppBar extends StatelessWidget {
  const _TripPlannerAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppColors.mobilePadding,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          InteractiveScale(
            hoverScale: 1.06,
            pressScale: 0.92,
            onTap: () => Navigator.of(context).maybePop(),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(999),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back, color: AppColors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Trip Planner',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          InteractiveScale(
            hoverScale: 1.06,
            pressScale: 0.92,
            onTap: () {},
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: AppColors.onSurfaceVariant),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded sheet: chips, warnings, timeline.
class _RouteSheet extends StatelessWidget {
  const _RouteSheet({
    required this.selectedTransport,
    required this.onTransportSelected,
    required this.transportName,
    required this.routeNumber,
    required this.departureTime,
  });

  final int selectedTransport;
  final ValueChanged<int> onTransportSelected;

  final String transportName;
  final String routeNumber;
  final String departureTime;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -28),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppColors.mobilePadding,
            12,
            AppColors.mobilePadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.outline.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (var i = 0; i < TripPlannerData.transportOptions.length; i++) ...[
                    if (i > 0) const SizedBox(width: 10),
                    TransportChip(
                      label: i == 0? transportName: 'Local',
                      isSelected: selectedTransport == i,
                      onTap: () => onTransportSelected(i),
                      icon: i == 0 ? Icons.airport_shuttle : Icons.directions_bus,
                    ),
                  ],
                ],
              )
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.05, end: 0),
              const SizedBox(height: 16),
              for (var i = 0; i < TripPlannerData.warnings.length; i++) ...[
                WarningCard(
                  icon: TripPlannerData.warnings[i].icon,
                  message: TripPlannerData.warnings[i].message,
                  animateDelayMs: 180 + (i * 80),
                ),
                if (i < TripPlannerData.warnings.length - 1) const SizedBox(height: 10),
              ],
              const SizedBox(height: 20),
              Text(
                'ROUTE TIMELINE',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              TripTimeline(
  stops: [
    TimelineStopData(
      type: TimelineStopType.origin,
      title: 'Tenkasi Junction',
      subtitle: 'Your location · Tamil Nadu, India',
      time: '5:24 pm',
    ),

    TimelineStopData(
      type: TimelineStopType.walk,
      title: 'Walk 2 min (120 m)',
      time: '',
    ),

   TimelineStopData(
  type: TimelineStopType.busStand,
  title: 'New Bus Stand',
  subtitle: '$routeNumber · To Shencottah',
  badge: 'Scheduled',
  time: departureTime,
  timeEmphasis: true,
),

    TimelineStopData(
      type: TimelineStopType.intermediate,
      title: 'Surandai Road',
      subtitle: '12 stops',
      time: '5:35 pm',
    ),

    TimelineStopData(
      type: TimelineStopType.walk,
      title: 'Walk 1 min (50 m)',
      time: '',
    ),

    TimelineStopData(
      type: TimelineStopType.destination,
      title: 'Thirumalai Kovil',
      subtitle: 'Tenkasi, Tamil Nadu',
      time: '5:40 pm',
    ),
  ],
),
            ],
          ),
        ),
      ),
    );
  }
}
