import 'package:flutter/material.dart';

import 'widgets/planner_action_buttons.dart';
import 'widgets/transport_chip.dart';
import 'widgets/trip_map_preview.dart';
import 'widgets/trip_timeline.dart';
import 'widgets/warning_card.dart';

/// Static dummy content for Trip Planner UI (no API).
abstract final class TripPlannerData {
  static const transportOptions = ['Lion Travels', 'Local'];

  static const warnings = [
    (
      icon: Icons.schedule,
      message: 'Evening peak — bus may be delayed by 10–15 min',
    ),
    (
      icon: Icons.cloudy_snowing,
      message: 'Light rain expected near Courtallam foothills',
    ),
  ];

  static const durationSummary = '31 min';
  static const arrivalSummary = 'Arrive at 5:55 pm';

  static const timelineStops = [
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
      subtitle: '147C · To Shencottah',
      badge: 'Scheduled',
      time: '5:25 pm',
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
  ];
}

enum TimelineStopType { origin, walk, busStand, intermediate, destination }

class TimelineStopData {
  const TimelineStopData({
    required this.type,
    required this.title,
    this.subtitle,
    this.badge,
    this.time = '',
    this.timeEmphasis = false,
  });

  final TimelineStopType type;
  final String title;
  final String? subtitle;
  final String? badge;
  final String time;
  final bool timeEmphasis;
}
