import 'package:flutter/material.dart';

/// Static route result types shown in the public transport sheet.
enum RouteCardType { busOnly, walkAndBus, train }

/// Dummy route data matching code.html route cards.
class RouteCardData {
  const RouteCardData({
    required this.type,
    required this.duration,
    required this.timeRange,
    required this.scheduleInfo,
    required this.price,
    this.busBadges = const [],
    this.walkMinutes,
    this.trainCode,
  });

  final RouteCardType type;
  final String duration;
  final String timeRange;
  final String scheduleInfo;
  final String price;
  final List<String> busBadges;
  final String? walkMinutes;
  final String? trainCode;
}

/// Transport mode chip data for the horizontal selector.
class TransportModeData {
  const TransportModeData({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.iconFilled = false,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final bool iconFilled;
}
