import 'package:flutter/material.dart';
import 'package:smartnav/features/maps/models/route_card_data.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

/// Single public-transport route result card from the results list.
class RouteCard extends StatelessWidget {
  const RouteCard({
    super.key,
    required this.data,
    this.onTap,
    this.animationDelay = Duration.zero,
  });

  final RouteCardData data;
  final VoidCallback? onTap;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    return _FadeInCard(
      delay: animationDelay,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              color: SmartNavColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: SmartNavColors.outlineVariant),
              boxShadow: SmartNavElevation.card,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RouteIconsRow(data: data),
                    const SizedBox(width: 10),
                    _DurationColumn(
                      duration: data.duration,
                      timeRange: data.timeRange,
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),

                Text(
                  data.routeName,
                  style: SmartNavTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

const SizedBox(height: 8),
                
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth - 48,
                          child: Text(
                            data.scheduleInfo,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: SmartNavTextStyles.labelSm.copyWith(
                              color: SmartNavColors.outline,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          data.price,
                          style: SmartNavTextStyles.labelLg.copyWith(
                            fontWeight: FontWeight.w700,
                            color: SmartNavColors.onSurface,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FadeInCard extends StatefulWidget {
  const _FadeInCard({required this.child, required this.delay});

  final Widget child;
  final Duration delay;

  @override
  State<_FadeInCard> createState() => _FadeInCardState();
}

class _FadeInCardState extends State<_FadeInCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future<void>.delayed(widget.delay, () {
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
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class _DurationColumn extends StatelessWidget {
  const _DurationColumn({
    required this.duration,
    required this.timeRange,
  });

  final String duration;
  final String timeRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(duration, style: SmartNavTextStyles.titleSm),
        const SizedBox(height: 2),
        Text(
          timeRange,
          style: SmartNavTextStyles.labelSm.copyWith(
            color: SmartNavColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _RouteIconsRow extends StatelessWidget {
  const _RouteIconsRow({required this.data});

  final RouteCardData data;

  @override
  Widget build(BuildContext context) {
    return switch (data.type) {
      RouteCardType.busOnly => Row(
  children: [
    const Icon(
      Icons.directions_bus,
      color: SmartNavColors.onSurfaceVariant,
      size: 22,
    ),

    const SizedBox(width: 8),

    if (data.busBadges.isNotEmpty)
      _BusBadge(label: data.busBadges.first),
  ],
),
      RouteCardType.walkAndBus => Row(
          children: [
            const Icon(
              Icons.directions_walk,
              color: SmartNavColors.outline,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              data.walkMinutes ?? '',
              style: SmartNavTextStyles.labelSm.copyWith(
                color: SmartNavColors.outline,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.chevron_right,
              color: SmartNavColors.outline,
              size: 16,
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.directions_bus,
              color: SmartNavColors.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(width: 8),
            if (data.busBadges.isNotEmpty)
              _BusBadge(label: data.busBadges.first),
          ],
        ),
      RouteCardType.train => Row(
          children: [
            const Icon(
              Icons.train,
              color: SmartNavColors.onSurfaceVariant,
              size: 22,
            ),
            const SizedBox(width: 10),
            if (data.trainCode != null) _BusBadge(label: data.trainCode!),
          ],
        ),
    };
  }
}

class _BusBadge extends StatelessWidget {
  const _BusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: SmartNavColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: SmartNavTextStyles.labelLg.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          fontSize: 12,
        ),
      ),
    );
  }
}
