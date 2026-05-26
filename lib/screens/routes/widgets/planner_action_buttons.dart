import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/animations/interactive_scale.dart';

/// Start + Save actions with trip duration summary.
class PlannerActionButtons extends StatelessWidget {
  const PlannerActionButtons({
    super.key,
    required this.duration,
    required this.arrival,
    this.onStart,
    this.onSave,
    this.animateDelayMs = 0,
  });

  final String duration;
  final String arrival;
  final VoidCallback? onStart;
  final VoidCallback? onSave;
  final int animateDelayMs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppColors.mobilePadding,
        16,
        AppColors.mobilePadding,
        8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      duration,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      arrival,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              InteractiveScale(
                onTap: onStart,
                hoverScale: 1.04,
                pressScale: 0.95,
                child: Material(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999),
                  elevation: 0,
                  child: InkWell(
                    onTap: onStart,
                    borderRadius: BorderRadius.circular(999),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.navigation_rounded,
                            color: AppColors.onPrimary,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Start',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InteractiveScale(
            onTap: onSave,
            hoverScale: 1.02,
            pressScale: 0.97,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onSave,
                icon: const Icon(Icons.bookmark_border, size: 20),
                label: Text(
                  'Save',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.outline),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: animateDelayMs))
        .fadeIn(duration: 450.ms)
        .slideY(begin: 0.08, end: 0, duration: 450.ms);
  }
}
