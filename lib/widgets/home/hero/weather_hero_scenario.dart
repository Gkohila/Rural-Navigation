import 'package:flutter/material.dart';

enum HeroSceneType { nightRain, sunnyMorning }

/// Dummy / live inputs for the animated weather hero.
class WeatherHeroScenario {
  const WeatherHeroScenario({
    required this.location,
    required this.weather,
    required this.timeLabel,
    required this.temperatureC,
    required this.sceneType,
    this.greeting = 'Vanakkam, Tenkasi!',
    this.subtitle,
    this.tempAnimateFrom,
    this.timeIcon = Icons.wb_sunny_outlined,
    this.timeAccent,
    this.weatherIcon = Icons.wb_sunny,
    this.weatherIconColor = const Color(0xFFFFE082),
    this.accentTextColor = const Color(0xFF9EB8D4),
  });

  final String location;
  final String weather;
  final String timeLabel;
  final String greeting;
  final String? subtitle;
  final double temperatureC;
  final double? tempAnimateFrom;
  final IconData timeIcon;
  final Color? timeAccent;
  final IconData weatherIcon;
  final Color weatherIconColor;
  final Color accentTextColor;
  final HeroSceneType sceneType;

  bool get isNight => sceneType == HeroSceneType.nightRain;

  /// Tenkasi Bus Stand — night, light rain (production default).
  static const tenkasiNightRain = WeatherHeroScenario(
    location: 'Tenkasi Bus Stand',
    weather: 'Light Rain',
    timeLabel: 'Night',
    temperatureC: 24,
    tempAnimateFrom: 20,
    sceneType: HeroSceneType.nightRain,
    timeIcon: Icons.nightlight_round,
    timeAccent: Color(0xFFFFD88A),
    weatherIcon: Icons.water_drop_rounded,
    weatherIconColor: Color(0xFF8EC5FF),
    subtitle: 'Feels like a calm TN night',
    accentTextColor: Color(0xFF9EB8D4),
  );

  /// Courtallam — sunny morning (dummy test scenario).
  static const courtallamSunnyMorning = WeatherHeroScenario(
    location: 'Courtallam',
    weather: 'Sunny',
    timeLabel: 'Morning',
    temperatureC: 24,
    tempAnimateFrom: 18,
    sceneType: HeroSceneType.sunnyMorning,
    greeting: 'Vanakkam, Courtallam!',
    timeIcon: Icons.wb_twilight,
    timeAccent: Color(0xFFFFE082),
    weatherIcon: Icons.wb_sunny_rounded,
    weatherIconColor: Color(0xFFFFD54F),
    subtitle: 'Clear skies over the falls',
    accentTextColor: Color(0xFF5D4037),
  );
}
