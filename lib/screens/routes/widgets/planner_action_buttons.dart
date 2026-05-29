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

    /// LEFT SIDE
    Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            duration,

            style: GoogleFonts.plusJakartaSans(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            arrival,

            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),

    /// SAVE BUTTON
    OutlinedButton.icon(

      onPressed: onSave,

      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        side: BorderSide(
          color: AppColors.outline,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(24),
        ),
      ),

      icon: const Icon(
        Icons.bookmark_border,
        size: 18,
      ),

      label: Text(
        'Save',

        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    const SizedBox(width: 10),

    /// START BUTTON
    ElevatedButton.icon(

      onPressed: onStart,

      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.primary,

        foregroundColor: Colors.white,

        elevation: 0,

        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),

        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(28),
        ),
      ),

      icon: const Icon(
        Icons.navigation,
        size: 18,
      ),

      label: Text(
        'Start',

        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ],
),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: animateDelayMs))
        .fadeIn(duration: 450.ms)
        .slideY(begin: 0.08, end: 0, duration: 450.ms);
  }
}
