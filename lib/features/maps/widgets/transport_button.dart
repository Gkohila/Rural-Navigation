import 'package:flutter/material.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

/// Transport mode chip (car, bike, bus, walk) from the mode selector row.
class TransportButton extends StatelessWidget {
  const TransportButton({
    super.key,
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.iconFilled = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final bool iconFilled;
  final VoidCallback? onTap;

  static const double _circleSize = 48;
  static const double _minWidth = 72;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: _minWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? SmartNavColors.primaryContainer
                    : SmartNavColors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22,
                color: isSelected
                    ? SmartNavColors.onPrimaryContainer
                    : SmartNavColors.onSurface,
                fill: iconFilled ? 1.0 : 0.0,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: SmartNavTextStyles.labelSm.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? SmartNavColors.primary
                    : SmartNavColors.onSurfaceVariant,
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: 32,
                        height: 3,
                        decoration: BoxDecoration(
                          color: SmartNavColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    )
                  : const SizedBox(height: 9),
            ),
          ],
        ),
      ),
    );
  }
}
