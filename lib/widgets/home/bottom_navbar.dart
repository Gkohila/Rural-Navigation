import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../animations/interactive_scale.dart';

import '../../screens/home/home_screen.dart';
import '../../screens/profile/profile_screen.dart';

/// ADD THIS IMPORT
import '../../features/maps/screens/route_search_screen.dart';

/// ADD THIS IMPORT
import '../../screens/alert/alerts_screen.dart';

enum HomeNavItem { home, routes, alerts, profile }

class HomeBottomNavbar extends StatelessWidget {

  const HomeBottomNavbar({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  final HomeNavItem selectedItem;
  final ValueChanged<HomeNavItem> onItemSelected;

  @override
  Widget build(BuildContext context) {

    return ClipRect(

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 14,
          sigmaY: 14,
        ),

        child: DecoratedBox(

          decoration: BoxDecoration(

            color:
                AppColors.surfaceContainerLowest
                    .withValues(alpha: 0.92),

            border: const Border(

              top: BorderSide(
                color:
                    AppColors.surfaceContainerHigh,
              ),
            ),

            boxShadow: const [

              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 16,
                offset: Offset(0, -4),
              ),
            ],
          ),

          child: SafeArea(

            top: false,

            child: Padding(

              padding:
                  const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                16,
              ),

              child: Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                children: [

                  /// HOME
                  _NavItem(

                    icon: Icons.home,
                    label: 'Home',

                    isSelected:
                        selectedItem ==
                            HomeNavItem.home,

                    onTap: () {

                      onItemSelected(
                        HomeNavItem.home,
                      );

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const HomeScreen(),
                        ),
                      );
                    },
                  ),

                  /// ROUTES
                  _NavItem(

                    icon:
                        Icons.directions_bus,

                    label: 'Routes',

                    isSelected:
                        selectedItem ==
                            HomeNavItem.routes,

                    onTap: () {

                      onItemSelected(
                        HomeNavItem.routes,
                      );

                      /// OPEN ROUTE SCREEN
                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const RouteSearchScreen(),
                        ),
                      );
                    },
                  ),

                  /// ALERTS
                  _NavItem(

                    icon:
                        Icons.notifications_outlined,

                    label: 'Alerts',

                    isSelected:
                        selectedItem ==
                            HomeNavItem.alerts,

                    onTap: () {

                      onItemSelected(
                        HomeNavItem.alerts,
                      );

                      /// OPEN ALERTS SCREEN
                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const AlertsScreen(),
                        ),
                      );
                    },
                  ),

                  /// PROFILE
                  _NavItem(

                    icon:
                        Icons.person_outline,

                    label: 'Profile',

                    isSelected:
                        selectedItem ==
                            HomeNavItem.profile,

                    onTap: () {

                      onItemSelected(
                        HomeNavItem.profile,
                      );

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                              const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(
          begin: 0.12,
          end: 0,
          duration: 500.ms,
        );
  }
}

class _NavItem extends StatelessWidget {

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    final inactiveColor =
        AppColors.onSurfaceVariant;

    return InteractiveScale(

      onTap: onTap,

      hoverScale: 1.08,
      pressScale: 0.92,

      child: Padding(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 280,
              ),

              curve:
                  Curves.easeOutCubic,

              padding:
                  EdgeInsets.symmetric(

                horizontal:
                    isSelected ? 20 : 0,

                vertical:
                    isSelected ? 8 : 0,
              ),

              decoration: isSelected

                  ? BoxDecoration(

                      color:
                          AppColors.primary,

                      borderRadius:
                          BorderRadius.circular(
                        999,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                              AppColors.primary
                                  .withValues(
                            alpha: 0.3,
                          ),

                          blurRadius: 10,

                          offset:
                              const Offset(
                            0,
                            3,
                          ),
                        ),
                      ],
                    )

                  : null,

              child: Icon(

                icon,

                size: 24,

                color: isSelected

                    ? AppColors.onPrimary

                    : inactiveColor,
              ),
            ),

            const SizedBox(height: 4),

            AnimatedDefaultTextStyle(

              duration:
                  const Duration(
                milliseconds: 220,
              ),

              curve: Curves.easeOut,

              style:
                  GoogleFonts.plusJakartaSans(

                fontSize: 10,

                fontWeight: isSelected

                    ? FontWeight.w700

                    : FontWeight.w500,

                color: isSelected

                    ? AppColors.primary

                    : inactiveColor,
              ),

              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}