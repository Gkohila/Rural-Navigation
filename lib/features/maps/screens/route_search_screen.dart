import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Design tokens (from HTML Tailwind config)
// ---------------------------------------------------------------------------

class _AppColors {
  static const Color background = Color(0xFFF9F9F9);
  static const Color surface = Color(0xFFF9F9F9);
  static const Color onSurface = Color(0xFF1A1C1C);
  static const Color onSurfaceVariant = Color(0xFF41493E);
  static const Color primary = Color(0xFF00450D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF1B5E20);
  static const Color onPrimaryContainer = Color(0xFF90D689);
  static const Color primaryFixed = Color(0xFFACF4A4);
  static const Color onPrimaryFixed = Color(0xFF002203);
  static const Color error = Color(0xFFBA1A1A);
  static const Color outline = Color(0xFF717A6D);
  static const Color outlineVariant = Color(0xFFC0C9BB);
  static const Color surfaceVariant = Color(0xFFE2E2E2);
  static const Color surfaceContainer = Color(0xFFEEEEEE);
  static const Color surfaceContainerLow = Color(0xFFF3F3F3);
  static const Color surfaceContainerHighest = Color(0xFFE2E2E2);
  static const Color secondary = Color(0xFF00639A);
}

class _AppText {
  static const TextStyle bodyMd = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    color: _AppColors.onSurface,
  );

  static const TextStyle labelLg = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.05 * 14,
    fontWeight: FontWeight.w600,
    color: _AppColors.onSurface,
  );

  static const TextStyle labelSm = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    color: _AppColors.onSurface,
  );

  static const TextStyle headlineMd = TextStyle(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w700,
    color: _AppColors.onSurface,
  );

  static TextStyle headlineMdPrimary = headlineMd.copyWith(
    color: _AppColors.primary,
    fontWeight: FontWeight.w600,
  );
}

// ---------------------------------------------------------------------------
// Custom route map (no network images)
// ---------------------------------------------------------------------------

class _RouteMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Light green map background
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFE8F4E6),
    );

    // Subtle grid / terrain blocks
    final gridPaint = Paint()
      ..color = const Color(0xFFD4E8D0)
      ..style = PaintingStyle.fill;
    for (var i = 0; i < 6; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (i * 73.0) % w,
            (i * 41.0 + 20) % (h * 0.6),
            48 + (i * 7.0),
            32 + (i * 5.0),
          ),
          const Radius.circular(8),
        ),
        gridPaint,
      );
    }

    // Blue route (secondary)
    _drawRoute(
      canvas,
      color: const Color(0xFF00639A),
      width: 4,
      start: Offset(w * 0.08, h * 0.72),
      control1: Offset(w * 0.35, h * 0.55),
      control2: Offset(w * 0.55, h * 0.78),
      end: Offset(w * 0.78, h * 0.62),
    );

    // Orange route (tertiary accent)
    _drawRoute(
      canvas,
      color: const Color(0xFFE07B39),
      width: 4,
      start: Offset(w * 0.15, h * 0.35),
      control1: Offset(w * 0.42, h * 0.28),
      control2: Offset(w * 0.62, h * 0.42),
      end: Offset(w * 0.88, h * 0.38),
    );

    // Main green curved route (matches HTML SVG)
    final greenPath = Path()
      ..moveTo(w * 0.2, h * 0.67)
      ..quadraticBezierTo(w * 0.4, h * 0.5, w * 0.6, h * 0.6)
      ..quadraticBezierTo(w * 0.75, h * 0.45, w * 1.0, h * 0.4);

    canvas.drawPath(
      greenPath,
      Paint()
        ..color = _AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round,
    );

    // Route stop circles
    _drawStop(canvas, Offset(w * 0.2, h * 0.67), _AppColors.primary);
    _drawStop(canvas, Offset(w * 1.0, h * 0.4), _AppColors.error);
    _drawStop(canvas, Offset(w * 0.78, h * 0.62), _AppColors.secondary);
    _drawStop(canvas, Offset(w * 0.88, h * 0.38), const Color(0xFFE07B39));
  }

  void _drawRoute(
    Canvas canvas, {
    required Color color,
    required double width,
    required Offset start,
    required Offset control1,
    required Offset control2,
    required Offset end,
  }) {
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(
        control1.dx,
        control1.dy,
        control2.dx,
        control2.dy,
        end.dx,
        end.dy,
      );
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawStop(Canvas canvas, Offset center, Color strokeColor) {
    canvas.drawCircle(center, 8, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      8,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class RouteSearchScreen extends StatelessWidget {
  const RouteSearchScreen({super.key});

  static const double _mapHeight = 300;
  static const double _sheetOverlap = 32;
  static const double _bottomNavHeight = 72;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopHeader(),
            const _SearchBarSection(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: _mapHeight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _RouteMapPainter(),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -_sheetOverlap),
                      child: const _BottomSheetContent(),
                    ),
                    SizedBox(
                      height: _bottomNavHeight +
                          MediaQuery.paddingOf(context).bottom +
                          16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: _AppColors.onPrimaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tenkasi SmartNav',
                style: _AppText.headlineMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _AppColors.primary,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: _AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'EN/தமிழ்',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search bar
// ---------------------------------------------------------------------------

class _SearchBarSection extends StatelessWidget {
  const _SearchBarSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: _AppColors.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    const Icon(
                      Icons.radio_button_unchecked,
                      size: 18,
                      color: _AppColors.primary,
                    ),
                    SizedBox(
                      height: 24,
                      child: CustomPaint(
                        size: const Size(1, 24),
                        painter: _DottedLinePainter(),
                      ),
                    ),
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: _AppColors.error,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _SearchField(value: 'Tenkasi', hint: 'Your location'),
                    const SizedBox(height: 8),
                    _SearchField(
                      value: 'Courtralam',
                      hint: 'Choose destination',
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Column(
                children: [
                  _IconCircleButton(
                    icon: Icons.swap_vert,
                    size: 32,
                    iconColor: _AppColors.outline,
                  ),
                  const SizedBox(height: 4),
                  _IconCircleButton(
                    icon: Icons.mic,
                    size: 40,
                    iconColor: _AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 3.0;
    const gap = 3.0;
    var y = 0.0;
    final paint = Paint()
      ..color = _AppColors.outline
      ..strokeWidth = 1;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, math.min(y + dashHeight, size.height)),
        paint,
      );
      y += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.value,
    required this.hint,
    this.showDivider = true,
  });

  final String value;
  final String hint;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: _AppText.bodyMd,
        ),
        if (showDivider) ...[
          const SizedBox(height: 4),
          Container(
            height: 1,
            color: _AppColors.outlineVariant,
          ),
        ],
      ],
    );
  }
}

class _IconCircleButton extends StatelessWidget {
  const _IconCircleButton({
    required this.icon,
    required this.size,
    required this.iconColor,
  });

  final IconData icon;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          customBorder: const CircleBorder(),
          child: Center(
            child: Icon(icon, size: 22, color: iconColor),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom sheet content (white rounded top)
// ---------------------------------------------------------------------------

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: _AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Public transport',
                  style: _AppText.headlineMd.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    _CircleActionButton(icon: Icons.tune),
                    const SizedBox(width: 8),
                    _CircleActionButton(icon: Icons.share),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _TransportModeChips(),
            const SizedBox(height: 16),
            const _FilterButtons(),
            const SizedBox(height: 24),
            const _RouteResultsList(),
          ],
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _AppColors.surfaceContainer,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {},
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            icon,
            color: _AppColors.onSurfaceVariant,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// Fix share/tune icons - I hardcoded tune in build. Let me fix in the write - actually I need to use `icon` parameter.

class _TransportModeChips extends StatelessWidget {
  const _TransportModeChips();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _TransportChip(
            icon: Icons.directions_car,
            label: '23 min',
            selected: false,
          ),
          SizedBox(width: 16),
          _TransportChip(
            icon: Icons.two_wheeler,
            label: '19 min',
            selected: false,
          ),
          SizedBox(width: 16),
          _TransportChip(
            icon: Icons.directions_bus,
            label: '32 min',
            selected: true,
          ),
          SizedBox(width: 16),
          _TransportChip(
            icon: Icons.directions_walk,
            label: '1 hr 38',
            selected: false,
          ),
        ],
      ),
    );
  }
}

class _TransportChip extends StatelessWidget {
  const _TransportChip({
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: selected
                  ? _AppColors.primaryContainer
                  : _AppColors.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: selected
                  ? _AppColors.onPrimaryContainer
                  : _AppColors.onSurface,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: _AppText.labelSm.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? _AppColors.primary : _AppColors.onSurface,
            ),
          ),
          if (selected) ...[
            const SizedBox(height: 4),
            Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                color: _AppColors.primary,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FilterButtons extends StatelessWidget {
  const _FilterButtons();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          _FilterChip(
            label: 'Leave 4:50 PM',
            trailingIcon: Icons.arrow_drop_down,
          ),
          SizedBox(width: 8),
          _FilterChip(
            label: 'Train +1',
            leadingIcon: Icons.check,
            trailingIcon: Icons.arrow_drop_down,
          ),
          SizedBox(width: 8),
          _FilterChip(
            label: 'Filter by',
            trailingIcon: Icons.arrow_drop_down,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
  });

  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _AppColors.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _AppColors.outlineVariant),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 18, color: _AppColors.onSurface),
                const SizedBox(width: 8),
              ],
              Text(label, style: _AppText.labelLg),
              if (trailingIcon != null) ...[
                const SizedBox(width: 4),
                Icon(trailingIcon, size: 18, color: _AppColors.onSurface),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Route cards & promo
// ---------------------------------------------------------------------------

class _RouteResultsList extends StatelessWidget {
  const _RouteResultsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RouteCard(
          leadingIcon: Icons.directions_bus,
          badges: const ['47D', '147C'],
          duration: '32 min',
          timeRange: '10:34 am – 11:05 am',
          subtitle: 'Scheduled at 10:35 am from Panagal Park',
          price: '₹9',
        ),
        const SizedBox(height: 16),
        _RouteCard(
          leadingIcons: const [
            Icons.directions_walk,
            Icons.chevron_right,
            Icons.directions_bus,
          ],
          walkMinutes: '8',
          badges: const ['47C'],
          duration: '32 min',
          timeRange: '10:40 am – 11:11 am',
          subtitle: 'Scheduled at 10:48 am from Thiyagaraya Nagar',
          price: '₹8',
        ),
        const SizedBox(height: 16),
        const _PromoCard(),
        const SizedBox(height: 16),
        _RouteCard(
          leadingIcon: Icons.train,
          badges: const ['TEN-MS'],
          duration: '28 min',
          timeRange: '10:55 am – 11:23 am',
          subtitle: 'Platform 2 • On time',
          price: '₹30',
        ),
      ],
    );
  }
}

class _RouteCard extends StatelessWidget {
  const _RouteCard({
    this.leadingIcon,
    this.leadingIcons,
    this.walkMinutes,
    required this.badges,
    required this.duration,
    required this.timeRange,
    required this.subtitle,
    required this.price,
  });

  final IconData? leadingIcon;
  final List<IconData>? leadingIcons;
  final String? walkMinutes;
  final List<String> badges;
  final String duration;
  final String timeRange;
  final String subtitle;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _AppColors.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: _AppColors.outlineVariant),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (leadingIcon != null)
                          Icon(
                            leadingIcon,
                            color: _AppColors.onSurfaceVariant,
                            size: 24,
                          ),
                        if (leadingIcons != null) ...[
                          Icon(
                            leadingIcons!.first,
                            color: _AppColors.outline,
                            size: 24,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            walkMinutes!,
                            style: _AppText.labelSm.copyWith(
                              color: _AppColors.outline,
                            ),
                          ),
                          Icon(
                            leadingIcons![1],
                            size: 16,
                            color: _AppColors.outline,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            leadingIcons![2],
                            color: _AppColors.onSurfaceVariant,
                            size: 24,
                          ),
                        ],
                        const SizedBox(width: 12),
                        ...badges.map(
                          (b) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _RouteBadge(label: b),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(duration, style: _AppText.headlineMdPrimary),
                      const SizedBox(height: 2),
                      Text(
                        timeRange,
                        style: _AppText.labelSm.copyWith(
                          color: _AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style: _AppText.labelSm.copyWith(
                        color: _AppColors.outline,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: _AppColors.onSurface,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteBadge extends StatelessWidget {
  const _RouteBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: _AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: _AppText.labelLg,
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  const _PromoCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 140,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0C5216),
                    Color(0xFF1B5E20),
                    Color(0xFF2A6B2C),
                  ],
                ),
              ),
            ),
            // Decorative landscape (no network image)
            Positioned(
              right: -20,
              bottom: -10,
              child: CustomPaint(
                size: const Size(180, 100),
                painter: _PromoLandscapePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Travel Greener',
                    style: _AppText.headlineMd.copyWith(
                      color: _AppColors.onPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Switch to EV transit for your daily commute.',
                    style: _AppText.labelSm.copyWith(
                      color: _AppColors.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: _AppColors.primaryFixed,
                      borderRadius: BorderRadius.circular(999),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(999),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          child: Text(
                            'Learn More',
                            style: _AppText.labelLg.copyWith(
                              color: _AppColors.onPrimaryFixed,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final hill = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width,
        size.height * 0.55,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      hill,
      Paint()..color = Colors.white.withValues(alpha: 0.12),
    );

    // Simple bus shape
    final busRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.35, size.height * 0.55, 72, 28),
      const Radius.circular(6),
    );
    canvas.drawRRect(
      busRect,
      Paint()..color = Colors.white.withValues(alpha: 0.25),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Bottom navigation (fixed)
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: BoxDecoration(
        color: _AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16 + bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home,
            label: 'Home',
            selected: false,
          ),
          _NavItem(
            icon: Icons.directions_bus,
            label: 'Routes',
            selected: true,
          ),
          _NavItem(
            icon: Icons.notifications,
            label: 'Alerts',
            selected: false,
          ),
          _NavItem(
            icon: Icons.person,
            label: 'Profile',
            selected: false,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: const BoxDecoration(
          color: _AppColors.primaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _AppColors.onPrimaryContainer, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: _AppText.labelSm.copyWith(
                fontWeight: FontWeight.w700,
                color: _AppColors.onPrimaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: _AppColors.onSurfaceVariant, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: _AppText.labelSm.copyWith(
                color: _AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Entry point (run: flutter run -t lib/features/maps/screens/route_search_screen.dart)
// ---------------------------------------------------------------------------

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _AppColors.background,
      ),
      home: const RouteSearchScreen(),
    ),
  );
}
