import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_colors.dart';
import '../trip_planner_data.dart';

/// Vertical transport timeline with route line and stop cards.
class TripTimeline extends StatelessWidget {
  const TripTimeline({
    super.key,
    required this.stops,
  });

  final List<TimelineStopData> stops;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 15,
          top: 28,
          bottom: 40,
          child: Container(
            width: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.surfaceContainer,
                  AppColors.secondaryContainer,
                  AppColors.secondaryContainer,
                  AppColors.surfaceContainer,
                ],
                stops: const [0, 0.2, 0.65, 1],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < stops.length; i++)
              _TimelineStopRow(
                stop: stops[i],
                isLast: i == stops.length - 1,
                index: i,
              ),
          ],
        ),
      ],
    );
  }
}

class _TimelineStopRow extends StatelessWidget {
  const _TimelineStopRow({
    required this.stop,
    required this.isLast,
    required this.index,
  });

  final TimelineStopData stop;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (stop.type == TimelineStopType.walk) {
      return Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TrackNode(stop: stop),
            const SizedBox(width: 12),
            Expanded(child: _WalkRow(stop: stop, index: index)),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TrackNode(stop: stop),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _StopContent(stop: stop)),
                if (stop.time.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  _TimeLabel(stop: stop),
                ],
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 450.ms)
        .slideX(begin: 0.04, end: 0, duration: 450.ms, curve: Curves.easeOutCubic);
  }
}

class _TrackNode extends StatelessWidget {
  const _TrackNode({required this.stop});

  final TimelineStopData stop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(child: _nodeIcon(stop)),
    );
  }

  Widget _nodeIcon(TimelineStopData stop) {
    switch (stop.type) {
      case TimelineStopType.busStand:
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.secondaryContainer,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            Icons.directions_bus,
            size: 18,
            color: AppColors.onPrimary,
          ),
        );
      case TimelineStopType.destination:
        return const Icon(Icons.location_on, color: Color(0xFFBA1A1A), size: 28);
      case TimelineStopType.walk:
        return Icon(Icons.directions_walk, color: AppColors.onSurfaceVariant, size: 24);
      case TimelineStopType.intermediate:
        return Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondaryContainer, width: 2),
          ),
        );
      case TimelineStopType.origin:
        return Icon(Icons.location_on_outlined, color: AppColors.onSurfaceVariant, size: 28);
    }
  }
}

class _WalkRow extends StatelessWidget {
  const _WalkRow({required this.stop, required this.index});

  final TimelineStopData stop;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.outline.withValues(alpha: 0.35),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                stop.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: AppColors.onSurfaceVariant),
          ],
        ),
      ),
    ).animate(delay: Duration(milliseconds: 100 * index)).fadeIn(duration: 400.ms);
  }
}

class _StopContent extends StatelessWidget {
  const _StopContent({required this.stop});

  final TimelineStopData stop;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stop.title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: AppColors.onSurface,
          ),
        ),
        if (stop.subtitle != null) ...[
          const SizedBox(height: 4),
          if (stop.type == TimelineStopType.busStand)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                stop.subtitle!,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
            )
          else
            Text(
              stop.subtitle!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.onSurfaceVariant,
              ),
            ),
        ],
        if (stop.badge != null) ...[
          const SizedBox(height: 6),
          Text(
            stop.badge!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
        ],
      ],
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.stop});

  final TimelineStopData stop;

  @override
  Widget build(BuildContext context) {
    if (stop.timeEmphasis) {
      final space = stop.time.lastIndexOf(' ');
      final timeMain = space > 0 ? stop.time.substring(0, space) : stop.time;
      final suffix = space > 0 ? stop.time.substring(space) : '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timeMain,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          if (suffix.isNotEmpty)
            Text(
              suffix.trim(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
        ],
      );
    }

    return Text(
      stop.time,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
    );
  }
}
