import 'package:flutter/material.dart';
import 'package:smartnav/features/maps/data/static_route_data.dart';
import 'package:smartnav/features/maps/widgets/bottom_nav_bar.dart';
import 'package:smartnav/features/maps/widgets/route_card.dart';
import 'package:smartnav/features/maps/widgets/route_map_painter.dart';
import 'package:smartnav/features/maps/widgets/transport_button.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

/// Tenkasi SmartNav route results screen — pixel match to designs/code.html.
class RouteSearchScreen extends StatefulWidget {
  const RouteSearchScreen({super.key});

  @override
  State<RouteSearchScreen> createState() => _RouteSearchScreenState();
}

class _RouteSearchScreenState extends State<RouteSearchScreen>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 1;
  int _selectedTransportIndex = 2;
  late final AnimationController _sheetAnimController;
  late final Animation<double> _sheetFade;
  late final Animation<Offset> _sheetSlide;

  @override
  void initState() {
    super.initState();
    _sheetAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _sheetFade = CurvedAnimation(
      parent: _sheetAnimController,
      curve: Curves.easeOut,
    );
    _sheetSlide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _sheetAnimController,
        curve: Curves.easeOutCubic,
      ),
    );
    _sheetAnimController.forward();
  }

  @override
  void dispose() {
    _sheetAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SmartNavTheme.light,
      child: Scaffold(
        backgroundColor: SmartNavColors.background,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ListView(
                shrinkWrap: false,
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(bottom: 140),
                children: [
                  const _AppHeader(),
                  const _RouteSearchBar(),
                  const _MapSection(),
                  FadeTransition(
                    opacity: _sheetFade,
                    child: SlideTransition(
                      position: _sheetSlide,
                      child: _PublicTransportSheet(
                        selectedTransportIndex: _selectedTransportIndex,
                        onTransportSelected: (index) {
                          setState(() => _selectedTransportIndex = index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SmartNavBottomBar(
                  selectedIndex: _bottomNavIndex,
                  onItemSelected: (index) {
                    setState(() => _bottomNavIndex = index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ——— Top navigation bar ———
class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: SmartNavSpacing.containerPaddingMobile,
        vertical: SmartNavSpacing.headerVertical,
      ),
      decoration: BoxDecoration(
        color: SmartNavColors.surface,
        boxShadow: SmartNavElevation.header,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const langButtonWidth = 72.0;
          final titleMaxWidth = constraints.maxWidth - 36 - 10 - 8 - langButtonWidth;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: SmartNavColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: SmartNavColors.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: titleMaxWidth.clamp(0, double.infinity),
                    child: Text(
                      'Tenkasi SmartNav',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: SmartNavTextStyles.headlineMdBold,
                    ),
                  ),
                ],
              ),
              TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: SmartNavColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'EN/தமிழ்',
              maxLines: 1,
              style: SmartNavTextStyles.labelLg.copyWith(
                color: SmartNavColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
                fontSize: 13,
              ),
              ),
            ),
          ],
          );
        },
      ),
    );
  }
}

// ——— Origin / destination search card ———
class _RouteSearchBar extends StatelessWidget {
  const _RouteSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: SmartNavSpacing.containerPaddingMobile,
        vertical: SmartNavSpacing.searchOuterVertical,
      ),
      color: SmartNavColors.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SmartNavColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: SmartNavElevation.card,
        ),
        child: Padding(
          padding: const EdgeInsets.all(SmartNavSpacing.searchInnerPadding),
          child: LayoutBuilder(
            builder: (context, constraints) {
              const markersWidth = 16.0;
              const actionsWidth = 36.0;
              const gaps = 10.0 + 6.0;
              final fieldsWidth =
                  constraints.maxWidth - markersWidth - actionsWidth - gaps;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.radio_button_unchecked,
                          size: 16,
                          color: SmartNavColors.primary,
                        ),
                        SizedBox(
                          height: 20,
                          child: CustomPaint(
                            size: const Size(1, 20),
                            painter: _DottedLinePainter(),
                          ),
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: SmartNavColors.error,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: fieldsWidth.clamp(0, double.infinity),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SearchField(
                          value: StaticRouteData.origin,
                          hint: 'Your location',
                          showDivider: true,
                        ),
                        const SizedBox(height: 6),
                        const _SearchField(
                          value: StaticRouteData.destination,
                          hint: 'Choose destination',
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CircleIconButton(
                        icon: Icons.swap_vert,
                        iconColor: SmartNavColors.outline,
                        size: 30,
                        iconSize: 20,
                      ),
                      const SizedBox(height: 2),
                      _CircleIconButton(
                        icon: Icons.mic,
                        iconColor: SmartNavColors.primary,
                        size: 36,
                        iconSize: 22,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.value,
    required this.hint,
    required this.showDivider,
  });

  final String value;
  final String hint;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          value.isNotEmpty ? value : hint,
          style: SmartNavTextStyles.bodyMd.copyWith(
            fontSize: 14,
            color: value.isNotEmpty
                ? SmartNavColors.onSurface
                : SmartNavColors.outline,
          ),
        ),
        if (showDivider) ...[
          const SizedBox(height: 3),
          const Divider(
            height: 1,
            thickness: 1,
            color: SmartNavColors.outlineVariant,
          ),
        ],
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.iconColor,
    required this.size,
    required this.iconSize,
  });

  final IconData icon;
  final Color iconColor;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {},
          child: Icon(icon, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 2.5;
    const gap = 2.5;
    final paint = Paint()
      ..color = SmartNavColors.outline
      ..strokeWidth = 1;

    var y = 0.0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y + dashHeight),
        paint,
      );
      y += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ——— Map with painted background + route overlay ———
class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SmartNavSpacing.mapHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const CustomPaint(
            painter: MapBackgroundPainter(),
            child: SizedBox.expand(),
          ),
          Opacity(
            opacity: 0.22,
            child: Image.network(
              StaticRouteData.mapImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: SmartNavSpacing.mapHeight,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
          const IgnorePointer(
            child: CustomPaint(
              painter: RouteMapPainter(),
              child: SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

// ——— Public transport bottom sheet (overlaps map) ———
class _PublicTransportSheet extends StatelessWidget {
  const _PublicTransportSheet({
    required this.selectedTransportIndex,
    required this.onTransportSelected,
  });

  final int selectedTransportIndex;
  final ValueChanged<int> onTransportSelected;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -SmartNavSpacing.sheetOverlap),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: SmartNavColors.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(SmartNavSpacing.sheetTopRadius),
          ),
          boxShadow: SmartNavElevation.sheet,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: SmartNavColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Public transport',
                    style: SmartNavTextStyles.headlineMd,
                  ),
                  Row(
                    children: [
                      _SheetIconButton(icon: Icons.tune),
                      const SizedBox(width: 8),
                      _SheetIconButton(icon: Icons.share),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _SpacedRow(
                height: 84,
                spacing: SmartNavSpacing.transportChipGap,
                children: [
                  for (var i = 0; i < StaticRouteData.transportModes.length; i++)
                    TransportButton(
                      icon: StaticRouteData.transportModes[i].icon,
                      label: StaticRouteData.transportModes[i].label,
                      isSelected: i == selectedTransportIndex,
                      iconFilled: StaticRouteData.transportModes[i].iconFilled,
                      onTap: () => onTransportSelected(i),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              
              SingleChildScrollView(
  scrollDirection: Axis.horizontal,

  child: Row(
    children: [

      for (var i = 0; i < StaticRouteData.filterChips.length; i++) ...[

        _FilterChip(
          label: StaticRouteData.filterChips[i],
          showCheck: i == 1,
        ),

        const SizedBox(width: 10),
      ],
    ],
  ),
),
              const SizedBox(height: 20),
              const _RouteResultsList(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Non-scrollable horizontal row (no nested scroll views).
class _SpacedRow extends StatelessWidget {
  const _SpacedRow({
    required this.children,
    this.height,
    this.spacing = 16,
  });

  final List<Widget> children;
  final double? height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: _withSpacing(children, spacing),
    );

    if (height != null) {
      return SizedBox(height: height, child: row);
    }
    return row;
  }

  List<Widget> _withSpacing(List<Widget> items, double gap) {
    if (items.isEmpty) return items;
    final spaced = <Widget>[items.first];
    for (var i = 1; i < items.length; i++) {
      spaced.add(SizedBox(width: gap));
      spaced.add(items[i]);
    }
    return spaced;
  }
}

class _SheetIconButton extends StatelessWidget {
  const _SheetIconButton({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SmartNavColors.surfaceContainer,
      shape: const CircleBorder(),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {},
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, color: SmartNavColors.onSurfaceVariant, size: 22),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    this.showCheck = false,
  });

  final String label;
  final bool showCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: SmartNavColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SmartNavColors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showCheck) ...[
            const Icon(Icons.check, size: 17, color: SmartNavColors.onSurface),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: SmartNavTextStyles.labelLg.copyWith(
              letterSpacing: 0,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(
            Icons.arrow_drop_down,
            size: 17,
            color: SmartNavColors.onSurface,
          ),
        ],
      ),
    );
  }
}

class _RouteResultsList extends StatelessWidget {
  const _RouteResultsList();

  @override
  Widget build(BuildContext context) {
    final cards = StaticRouteData.routeCards;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RouteCard(
          data: cards[0],
          animationDelay: Duration.zero,
        ),
        const SizedBox(height: SmartNavSpacing.cardGap),
        RouteCard(
          data: cards[1],
          animationDelay: const Duration(milliseconds: 60),
        ),
        const SizedBox(height: SmartNavSpacing.cardGap),
        const _EvPromoCard(),
        const SizedBox(height: SmartNavSpacing.cardGap),
        RouteCard(
          data: cards[2],
          animationDelay: const Duration(milliseconds: 180),
        ),
      ],
    );
  }
}

class _EvPromoCard extends StatefulWidget {
  const _EvPromoCard();

  @override
  State<_EvPromoCard> createState() => _EvPromoCardState();
}

class _EvPromoCardState extends State<_EvPromoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  /// Responsive promo height — avoids overflow on Pixel 6/7 and smaller devices.
  static double _cardHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final textScale = MediaQuery.textScalerOf(context).scale(14) / 14;
    final base = width < 360 ? 162.0 : width < 400 ? 156.0 : 152.0;
    return base * textScale.clamp(1.0, 1.2);
  }

  static EdgeInsets _cardPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < 360 ? 18.0 : 22.0;
    return EdgeInsets.fromLTRB(horizontal, 18, horizontal, 18);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    Future<void>.delayed(const Duration(milliseconds: 120), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = _cardHeight(context);
    final padding = _cardPadding(context);
    const buttonHeight = 36.0;

    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: cardHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: SmartNavColors.primary),
              Opacity(
                opacity: 0.3,
                child: Image.network(
                  StaticRouteData.evPromoImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
              // Text block — top area only (no Column competing with button).
              Padding(
                padding: EdgeInsets.only(
                  left: padding.left,
                  top: padding.top,
                  right: padding.right,
                  bottom: padding.bottom + buttonHeight + 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Travel Greener',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: SmartNavTextStyles.headlineMd.copyWith(
                        color: SmartNavColors.onPrimary,
                        fontSize: 20,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Switch to EV transit for your daily commute.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: SmartNavTextStyles.labelSm.copyWith(
                        color: SmartNavColors.onPrimary.withValues(alpha: 0.9),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              // Button pinned to bottom with safe inset.
              Positioned(
                left: padding.left,
                right: padding.right,
                bottom: padding.bottom,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: SmartNavColors.primaryFixed,
                      foregroundColor: SmartNavColors.onPrimaryFixed,
                      minimumSize: const Size(0, buttonHeight),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
  horizontal: 12,
  vertical: 10,
),
                      shape: const StadiumBorder(),
                      elevation: 0,
                    ),
                    child: Text(
                      'Learn More',
                      style: SmartNavTextStyles.labelLg.copyWith(
                        color: SmartNavColors.onPrimaryFixed,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
