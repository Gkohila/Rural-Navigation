import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../animations/interactive_scale.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.onTap,
    this.animateDelayMs = 0,
    this.floatPhaseMs = 0,
  });

  final IconData icon;
  final String label;
  final Color iconBackgroundColor;
  final Color iconColor;

  final VoidCallback? onTap;

  final int animateDelayMs;
  final int floatPhaseMs;

  @override
  Widget build(BuildContext context) {
    return InteractiveScale(

      onTap: onTap,

      child: Material(
        color: AppColors.surfaceContainerLowest,

        borderRadius: BorderRadius.circular(24),

        elevation: 0,

        child: InkWell(

          onTap: onTap,

          borderRadius: BorderRadius.circular(24),

          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              border: Border.all(
                color: AppColors.surfaceContainer,
              ),

              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 280),

                    curve: Curves.easeOutCubic,

                    width: 48,
                    height: 48,

                    decoration: BoxDecoration(
                      color: iconBackgroundColor,

                      borderRadius: BorderRadius.circular(16),

                      boxShadow: [
                        BoxShadow(
                          color: iconBackgroundColor.withValues(alpha: 0.35),

                          blurRadius: 8,

                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),

                    child: Icon(
                      icon,
                      size: 24,
                      color: iconColor,
                    ),
                  )
                      .animate(
                        onPlay: (c) => c.repeat(reverse: true),

                        delay: Duration(
                          milliseconds: floatPhaseMs,
                        ),
                      )
                      .moveY(
                        begin: 0,
                        end: -2,

                        duration: 2.2.seconds,

                        curve: Curves.easeInOut,
                      ),

                  const SizedBox(height: 12),

                  Text(
                    label,

                    textAlign: TextAlign.center,

                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,

                      fontWeight: FontWeight.w600,

                      height: 1.25,

                      letterSpacing: 0.7,

                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate(
          delay: Duration(
            milliseconds: animateDelayMs,
          ),
        )
        .fadeIn(
          duration: 420.ms,
          curve: Curves.easeOut,
        )
        .slideY(
          begin: 0.06,
          end: 0,

          duration: 420.ms,

          curve: Curves.easeOutCubic,
        );
  }
}