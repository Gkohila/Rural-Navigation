import 'package:flutter/material.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';
import '../../../screens/home/home_screen.dart';
import '../../../screens/profile/profile_screen.dart';
import 'package:smartnav/screens/notification/notification_screen.dart';
import 'package:smartnav/services/alert_service.dart';

/// Fixed bottom navigation matching the HTML nav bar.
class SmartNavBottomBar extends StatelessWidget {
  const SmartNavBottomBar({
    super.key,
    this.selectedIndex = 1,
    this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  static const double contentHeight = 64;

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.directions_bus, label: 'Routes', filled: true),
    _NavItem(icon: Icons.notifications, label: 'Alerts'),
    _NavItem(icon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SmartNavColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        boxShadow: SmartNavElevation.bottomNav,
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: SizedBox(
            height: contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) {
                  final item = _items[index];
                  final isSelected = index == selectedIndex;

                  return _BottomNavButton(
                    item: item,
                    isSelected: isSelected,
                    onTap: () {
                      onItemSelected?.call(index);

                      if (index == 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NotificationScreen(),
                          ),
                        );
                      } else if (index == 3) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.label,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final bool filled;
}

class _BottomNavButton extends StatefulWidget {

  const _BottomNavButton({
    required this.item,
    required this.isSelected,
    this.onTap,
  });

  final _NavItem item;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<_BottomNavButton> createState() =>
      _BottomNavButtonState();
}

class _BottomNavButtonState
    extends State<_BottomNavButton> {

  final AlertService alertService =
      AlertService();

  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadUnreadCount();
  }

  Future<void> loadUnreadCount() async {

    unreadCount =
        await alertService.getUnreadCount(
      "147C",
    );

    if (mounted) {
      setState(() {});
    }
  }

  Widget buildNavIcon(Color color) {
    if (widget.item.label == 'Alerts') {
      return Badge(

      isLabelVisible: unreadCount > 0,

      label: Text(
        unreadCount.toString(),
      ),

      child: Icon(
        widget.item.icon,
        color: color,
        size: 22,
      ),
      );
    }

    return Icon(
      widget.item.icon,
      color: color,
      size: 22,
      fill: widget.item.filled ? 1.0 : 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
if (widget.isSelected) {
        return GestureDetector(
          onTap: widget.onTap, 
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: SmartNavColors.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildNavIcon(
                SmartNavColors.onPrimaryContainer,
              ),
              const SizedBox(height: 2),
              Text(
                widget.item.label,
                style: SmartNavTextStyles.labelSm.copyWith(
                  fontWeight: FontWeight.w700,
                  color: SmartNavColors.onPrimaryContainer,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
        onTap: widget.onTap,        child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavIcon(
              SmartNavColors.onSurfaceVariant,
            ),
            const SizedBox(height: 2),
            Text(
              widget.item.label,
              style: SmartNavTextStyles.labelSm.copyWith(
                color: SmartNavColors.onSurfaceVariant,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}