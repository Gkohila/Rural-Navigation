import 'package:flutter/material.dart';
import 'package:smartnav/features/maps/models/route_card_data.dart';

/// Static content from designs/code.html.
abstract final class StaticRouteData {
  static const String mapImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAyCkvJ0Y7TQIa7-8yV5Mlc2mMvLg5ZuRu9Sm15f3YUpheJVQlPC3jL-MPGFY8e6bPTyTLdwfEtNMOq41_ReXOrx6eZMbdX3A2oHD-xAiG8folKuTaj8MqFX74wBCziEz3xCfg7u5EAAkCSw9noUj64ncxp36WZdDpv8GlB9Fl-FbMPS-4x-VZB0qOGz3Pbnrzf8LEdTMYkL5mGUm2ZMcbTNhYkQm3rWufP3cWLxxFZ_HwVfueZZ-1xP5QkDe7lO_6cmKVETPp4RtgZ';

  static const String evPromoImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC7QKSOHgN5yQQI_cXwNoObyqGVNer90ptqesZga41puNQUJ1ipkMpb1gUTP3vSbZ989GSOVEz7N7V1nVRuevHcQB4lTZ6TkdLz8on0SkFYeXB4y7J2uBMAo3UAH1ag0otOsD8aH4qMwXZGM0YFjzBlGDOrqKMIqADLnISzVVeoA6sUKLh1PtogN9NnuSzzEtpz-3Q-6zAk5MfKKTVGyleY-RMu1RH9wMDyR-_nMxKmekcMF_QyJ8Bv_JvAbk5y1gXJHk-DAAXEDJvc';

  static const String origin = 'Tenkasi';
  static const String destination = 'Courtralam';

  static const List<TransportModeData> transportModes = [
    TransportModeData(icon: Icons.directions_car, label: '23 min'),
    TransportModeData(icon: Icons.two_wheeler, label: '19 min'),
    TransportModeData(
      icon: Icons.directions_bus,
      label: '32 min',
      isSelected: true,
      iconFilled: true,
    ),
    TransportModeData(icon: Icons.directions_walk, label: '1 hr 38'),
  ];

  static const List<String> filterChips = [
    'Leave 4:50 PM',
    'Preferred modes',
    'Filter by',
  ];

  static const List<RouteCardData> routeCards = [
    RouteCardData(
      type: RouteCardType.busOnly,
      duration: '32 min',
      timeRange: '10:34 am – 11:05 am',
      scheduleInfo: 'Scheduled at 10:35 am from Panagal Park',
      price: '₹9',
      routeName: 'Tenkasi → Shencottah',
      busBadges: ['47D', '147C'],
    ),
    RouteCardData(
      type: RouteCardType.walkAndBus,
      duration: '32 min',
      timeRange: '10:40 am – 11:11 am',
      scheduleInfo: 'Scheduled at 10:48 am from Thiyagaraya Nagar',
      price: '₹8',
      routeName: 'Tenkasi → Courtallam',
      walkMinutes: '8',
      busBadges: ['47C'],
    ),
    RouteCardData(
      type: RouteCardType.train,
      duration: '28 min',
      timeRange: '10:55 am – 11:23 am',
      scheduleInfo: 'Platform 2 • On time',
      price: '₹30',
      routeName: 'Tenkasi → Madurai',
      trainCode: 'TEN-MS',
    ),
  ];
}
