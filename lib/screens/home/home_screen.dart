import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/animations/interactive_scale.dart';
import '../../widgets/home/animated_hero_section.dart';
import '../../widgets/home/hero/weather_hero_scenario.dart';
import '../../widgets/home/bottom_navbar.dart';
import '../../widgets/home/quick_action_card.dart';
import '../../widgets/home/route_card.dart';
import '../../features/maps/screens/route_search_screen.dart';

import '../navigation/active_trip_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class _QuickActionsSection
    extends StatelessWidget {

  const _QuickActionsSection();

  static const _actions = [

    (
      icon: Icons.directions_bus,
      label: 'Find Bus/Train',
      bg: AppColors.secondaryContainer,
      fg: AppColors.onSecondaryContainer,
      delay: 320,
      float: 0,
    ),

    (
      icon: Icons.history,
      label: 'Recent Search History',
      bg: AppColors.tertiaryContainer,
      fg: AppColors.onTertiaryContainer,
      delay: 400,
      float: 400,
    ),

    (
      icon: Icons.near_me,
      label: 'Live Navigation',
      bg: AppColors.primaryContainer,
      fg: AppColors.onPrimaryContainer,
      delay: 480,
      float: 800,
    ),

    (
      icon: Icons.map_outlined,
      label: 'Nearby Stops',
      bg: AppColors.secondaryContainer,
      fg: AppColors.onSecondaryContainer,
      delay: 560,
      float: 1200,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(
          'QUICK ACTIONS',

          style:
              GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color:
                AppColors.onSurfaceVariant,
          ),
        )
            .animate(delay: 280.ms)
            .fadeIn(duration: 350.ms),

        const SizedBox(height: 16),

        LayoutBuilder(

          builder: (context, constraints) {

            final itemWidth =
                (constraints.maxWidth -
                        AppColors.cardGap) /
                    2;

            return Wrap(

              spacing: AppColors.cardGap,
              runSpacing: AppColors.cardGap,

              children: [

                for (final action in _actions)

                  SizedBox(
                    width: itemWidth,

                    child: QuickActionCard(

                      icon: action.icon,
                      label: action.label,

                      iconBackgroundColor:
                          action.bg,

                      iconColor: action.fg,

                      animateDelayMs:
                          action.delay,

                      floatPhaseMs:
                          action.float,

                      onTap: () {

  /// FIND BUS/TRAIN
  if (action.label == 'Find Bus/Train') {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            const RouteSearchScreen(),
      ),
    );
  }

  /// RECENT SEARCH HISTORY
  else if (action.label ==
      'Recent Search History') {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            const RecentSearchScreen(),
      ),
    );
  }

  /// LIVE NAVIGATION
  else if (action.label ==
      'Live Navigation') {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            const LiveNavigationScreen(),
      ),
    );
  }

  /// NEARBY STOPS
  else if (action.label ==
      'Nearby Stops') {

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (context) =>
            const NearbyStopsScreen(),
      ),
    );
  }
},
),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SavedRoutesSection
    extends StatelessWidget {

  const _SavedRoutesSection({

    required this.routeImageCourtallam,
    required this.routeImageTirunelveli,
  });

  final String routeImageCourtallam;
  final String routeImageTirunelveli;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(
          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [

            Text(
              'SAVED ROUTES',

              style:
                  GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight:
                    FontWeight.w600,
                letterSpacing: 1.1,
                color:
                    AppColors.onSurfaceVariant,
              ),
            )
                .animate(delay: 600.ms)
                .fadeIn(duration: 350.ms),

            InteractiveScale(
              hoverScale: 1.05,
              pressScale: 0.95,

              onTap: () {},

              child: Text(
                'View All',

                style:
                    GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      AppColors.primary,
                ),
              ),
            )
                .animate(delay: 640.ms)
                .fadeIn(duration: 350.ms),
          ],
        ),

        const SizedBox(height: 16),

        SizedBox(
          height: 220,

          child: ListView(
            scrollDirection:
                Axis.horizontal,

            clipBehavior: Clip.none,

            padding:
                const EdgeInsets.only(
                    bottom: 8),

            children: [

              RouteCard(
                imageUrl:
                    routeImageCourtallam,

                fromCity: 'Tenkasi',

                toCity: 'Courtallam',
                duration: '15 mins',

                frequencyLabel:
                    'Every 10m',

                frequencyIcon:
                    Icons.directions_bus,

                frequencyColor:
                    AppColors.primary,

                animateDelayMs: 680,
              ),

              const SizedBox(
                width: AppColors.cardGap,
              ),

              RouteCard(
                imageUrl: routeImageTirunelveli,
                imageBackgroundColor: AppColors.secondaryFixed,
                fromCity: 'Sengottai',

                toCity: 'Tirunelveli',

                duration: '1h 20m',

                frequencyLabel:
                    '3 trains daily',

                frequencyIcon:
                    Icons.train,

                frequencyColor:
                    AppColors.secondary,

                animateDelayMs: 760,
              ),
            ],
          ),
        ),
      ],
    );
  }
}