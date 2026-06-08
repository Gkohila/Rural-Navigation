import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../animations/interactive_scale.dart';

class RouteCard extends StatelessWidget {
  const RouteCard({
    super.key,
    required this.imageUrl,
    required this.fromCity,
    required this.toCity,
    required this.duration,
    required this.frequencyLabel,
    required this.frequencyIcon,
    required this.frequencyColor,
    this.imageBackgroundColor,
    this.width = 280,
    this.onTap,
    this.animateDelayMs = 0,
  });

  final String imageUrl;
  final Color? imageBackgroundColor;
  final String fromCity;
  final String toCity;
  final String duration;
  final String frequencyLabel;
  final IconData frequencyIcon;
  final Color frequencyColor;
  final double width;
  final VoidCallback? onTap;
  final int animateDelayMs;

  static const double _imageHeight = 112;

  @override
  Widget build(BuildContext context) {
    return InteractiveScale(
      onTap: onTap,
      hoverScale: 1.02,
      child: SizedBox(
        width: width,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.surfaceContainer),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: _imageHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ColoredBox(
                        color:
                            imageBackgroundColor ?? AppColors.surfaceContainer,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.outline,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
  children: [
    Expanded(
      child: Text(
        fromCity,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    ),
    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Icon(
        Icons.arrow_forward,
        size: 16,
        color: AppColors.outline,
      ),
    ),
    Expanded(
      child: Text(
        toCity,
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    ),
  ],
),
                      const SizedBox(height: 12),
                      Wrap(
  spacing: 10,
  runSpacing: 6,
                        children: [
                          _MetaRow(
                            icon: Icons.schedule,
                            label: duration,
                            color: AppColors.onSurfaceVariant,
                          ),
                          _MetaRow(
                            icon: frequencyIcon,
                            label: frequencyLabel,
                            color: frequencyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: animateDelayMs))
        .fadeIn(duration: 480.ms, curve: Curves.easeOut)
        .slideX(begin: 0.04, end: 0, duration: 480.ms, curve: Curves.easeOutCubic);
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
@override
Widget build(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        size: 16,
        color: color,
      ),
      const SizedBox(width: 6),
      SizedBox(
        width: 90,
        child: Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    ],
  );
}
}
