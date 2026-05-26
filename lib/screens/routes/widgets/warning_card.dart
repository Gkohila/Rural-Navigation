import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';


/// Soft yellow alert card with icon and message.
class WarningCard extends StatelessWidget {
  const WarningCard({
    super.key,
    required this.icon,
    required this.message,
    this.animateDelayMs = 0,
  });

  final IconData icon;
  final String message;
  final int animateDelayMs;

  static const Color _background = Color(0xFFFFF8E1);
  static const Color _border = Color(0xFFFFE082);
  static const Color _iconColor = Color(0xFFF57F17);
  static const Color _textColor = Color(0xFF5D4037);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border.withValues(alpha: 0.6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: _iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.35,
                color: _textColor,
              ),
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: animateDelayMs))
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.05, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}
