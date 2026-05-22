import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animations/glass_container.dart';
import '../animations/interactive_scale.dart';
import '../animations/light_rain_effect.dart';
import 'hero/morning_environment_scene.dart';
import 'hero/night_environment_scene.dart';
import 'hero/weather_hero_scenario.dart';

/// Contextual weather hero driven by [WeatherHeroScenario].
class AnimatedHeroSection extends StatefulWidget {
  const AnimatedHeroSection({
    super.key,
    this.scenario = WeatherHeroScenario.courtallamSunnyMorning,
  });

  final WeatherHeroScenario scenario;

  @override
  State<AnimatedHeroSection> createState() => _AnimatedHeroSectionState();
}

class _AnimatedHeroSectionState extends State<AnimatedHeroSection> {
  bool _heroHovered = false;

  WeatherHeroScenario get _s => widget.scenario;

  @override
  Widget build(BuildContext context) {
    final isNight = _s.isNight;
    final textOnHero = isNight ? Colors.white : const Color(0xFF1A1C1C);
    final chipText = isNight
        ? Colors.white.withValues(alpha: 0.95)
        : Colors.white.withValues(alpha: 0.98);

    return MouseRegion(
      onEnter: (_) => setState(() => _heroHovered = true),
      onExit: (_) => setState(() => _heroHovered = false),
      child: AnimatedScale(
        scale: _heroHovered ? 1.008 : 1,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: isNight
                    ? const Color(0xFF0A1628).withValues(alpha: 0.45)
                    : const Color(0xFF4A90D9).withValues(alpha: 0.25),
                blurRadius: 28,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: (isNight
                        ? const Color(0xFFFFC96B)
                        : const Color(0xFFFFD54F))
                    .withValues(alpha: 0.12),
                blurRadius: 40,
                spreadRadius: -8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: SizedBox(
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: _HeroBackdrop(
                      key: ValueKey(_s.sceneType),
                      scenario: _s,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                            color: _s.accentTextColor,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                            .slideY(begin: 0.12, end: 0, duration: 500.ms),
                        const SizedBox(height: 4),
                        Text(
                          _s.greeting,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: textOnHero,
                          ),
                        )
                            .animate(delay: 80.ms)
                            .fadeIn(duration: 550.ms)
                            .slideY(begin: 0.1, end: 0, duration: 550.ms),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _GlassChip(
                              icon: Icons.location_on,
                              label: _s.location,
                              isNight: isNight,
                              textColor: chipText,
                            ),
                            const SizedBox(width: 8),
                            _GlassChip(
                              icon: _s.timeIcon,
                              label: _s.timeLabel,
                              accent: _s.timeAccent,
                              isNight: isNight,
                              textColor: chipText,
                            ),
                          ],
                        )
                            .animate(delay: 160.ms)
                            .fadeIn(duration: 450.ms)
                            .slideX(begin: -0.03, end: 0, duration: 450.ms),
                        const Spacer(),
                        _WeatherGlassCard(
                          scenario: _s,
                          textColor: textOnHero,
                        )
                            .animate(delay: 240.ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.06, end: 0, duration: 500.ms),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 650.ms)
        .scale(
          begin: const Offset(0.97, 0.97),
          end: const Offset(1, 1),
          duration: 650.ms,
          curve: Curves.easeOutCubic,
        );
  }
}

class _HeroBackdrop extends StatelessWidget {
  const _HeroBackdrop({super.key, required this.scenario});

  final WeatherHeroScenario scenario;

  @override
  Widget build(BuildContext context) {
    if (scenario.isNight) {
      return Stack(
        fit: StackFit.expand,
        children: [
          const NightEnvironmentScene(),
          const LightRainEffect(
            dropCount: 48,
            opacity: 0.14,
            color: Color(0xFFB8CBE8),
          ),
          const _DriftingClouds(isNight: true),
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        const MorningEnvironmentScene(),
        const _DriftingClouds(isNight: false),
      ],
    );
  }
}

class _DriftingClouds extends StatelessWidget {
  const _DriftingClouds({required this.isNight});

  final bool isNight;

  @override
  Widget build(BuildContext context) {
    final cloudColor = isNight
        ? Colors.white.withValues(alpha: 0.07)
        : Colors.white.withValues(alpha: 0.55);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 6,
              left: 20,
              child: Icon(Icons.cloud, size: 72, color: cloudColor)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveX(
                    begin: -10,
                    end: 12,
                    duration: 11.seconds,
                    curve: Curves.easeInOut,
                  ),
            ),
            Positioned(
              top: 28,
              right: 24,
              child: Icon(Icons.cloud_queue, size: 96, color: cloudColor)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveX(
                    begin: 10,
                    end: -14,
                    duration: 9.seconds,
                    curve: Curves.easeInOut,
                  ),
            ),
            Positioned(
              top: 52,
              left: constraints.maxWidth * 0.38,
              child: Icon(Icons.cloud, size: 44, color: cloudColor)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .moveX(
                    begin: 6,
                    end: -8,
                    duration: 13.seconds,
                    curve: Curves.easeInOut,
                  )
                  .fadeIn(duration: 600.ms),
            ),
          ],
        );
      },
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({
    required this.icon,
    required this.label,
    required this.isNight,
    required this.textColor,
    this.accent,
  });

  final IconData icon;
  final String label;
  final bool isNight;
  final Color textColor;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return InteractiveScale(
      hoverScale: 1.04,
      pressScale: 0.97,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(999),
        blurSigma: 8,
        fillColor: Colors.white.withValues(alpha: isNight ? 0.08 : 0.22),
        borderColor: Colors.white.withValues(alpha: isNight ? 0.16 : 0.35),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: accent ?? textColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherGlassCard extends StatefulWidget {
  const _WeatherGlassCard({
    required this.scenario,
    required this.textColor,
  });

  final WeatherHeroScenario scenario;
  final Color textColor;

  @override
  State<_WeatherGlassCard> createState() => _WeatherGlassCardState();
}

class _WeatherGlassCardState extends State<_WeatherGlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.scenario;
    final isNight = s.isNight;
    final from = s.tempAnimateFrom ?? (s.temperatureC - 4);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.02 : 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        alignment: Alignment.centerLeft,
        child: InteractiveScale(
          hoverScale: 1.01,
          pressScale: 0.98,
          child: GlassContainer(
            borderRadius: BorderRadius.circular(16),
            blurSigma: 12,
            fillColor: Colors.white.withValues(
              alpha: _hovered ? (isNight ? 0.14 : 0.28) : (isNight ? 0.1 : 0.22),
            ),
            borderColor: Colors.white.withValues(
              alpha: _hovered ? (isNight ? 0.22 : 0.4) : (isNight ? 0.16 : 0.32),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<double>(
                        key: ValueKey(s.temperatureC),
                        tween: Tween<double>(begin: from, end: s.temperatureC),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Text(
                            '${value.round()}°C',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: widget.textColor,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 2),
                      Text(
                        s.weather,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: isNight
                              ? const Color(0xFFB8CBE8)
                              : const Color(0xFF5D4037),
                        ),
                      ).animate(delay: 350.ms).fadeIn(duration: 400.ms),
                      if (s.subtitle != null)
                        Text(
                          s.subtitle!,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: widget.textColor.withValues(alpha: 0.65),
                          ),
                        ).animate(delay: 450.ms).fadeIn(duration: 400.ms),
                    ],
                  ),
                ),
                Icon(
                  s.weatherIcon,
                  size: 34,
                  color: s.weatherIconColor.withValues(alpha: 0.95),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 0,
                      end: -2,
                      duration: 2.seconds,
                      curve: Curves.easeInOut,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
