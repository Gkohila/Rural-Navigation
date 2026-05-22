import 'package:flutter/material.dart';

/// Hover (desktop) and press scale feedback with smooth transitions.
class InteractiveScale extends StatefulWidget {
  const InteractiveScale({
    super.key,
    required this.child,
    this.onTap,
    this.hoverScale = 1.03,
    this.pressScale = 0.96,
    this.duration = const Duration(milliseconds: 200),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double hoverScale;
  final double pressScale;
  final Duration duration;

  @override
  State<InteractiveScale> createState() => _InteractiveScaleState();
}

class _InteractiveScaleState extends State<InteractiveScale> {
  bool _hovered = false;
  bool _pressed = false;

  double get _targetScale {
    if (_pressed) return widget.pressScale;
    if (_hovered) return widget.hoverScale;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: _targetScale,
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
