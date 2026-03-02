import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';
import 'theme.dart';

/// Main app shell with bottom navigation
class ShellScreen extends StatelessWidget {
  final Widget child;

  const ShellScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return NavigationBar(
      selectedIndex: _getSelectedIndex(location),
      onDestinationSelected: (index) => _onItemTapped(context, index),
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.3),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 65,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined, size: 22),
          selectedIcon: Icon(Icons.dashboard, size: 22),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.emoji_events_outlined, size: 22),
          selectedIcon: Icon(Icons.emoji_events, size: 22),
          label: 'Events',
        ),
        NavigationDestination(
          icon: Icon(Icons.golf_course_outlined, size: 22),
          selectedIcon: Icon(Icons.golf_course, size: 22),
          label: 'Handicap',
        ),
        NavigationDestination(
          icon: Icon(Icons.flag_outlined, size: 22),
          selectedIcon: Icon(Icons.flag, size: 22),
          label: 'Goals',
        ),
        NavigationDestination(
          icon: Icon(Icons.analytics_outlined, size: 22),
          selectedIcon: Icon(Icons.analytics, size: 22),
          label: 'Stats',
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith(AppRoutes.dashboard)) return 0;
    if (location.startsWith(AppRoutes.tournaments)) return 1;
    if (location.startsWith(AppRoutes.handicap)) return 2;
    if (location.startsWith(AppRoutes.milestones)) return 3;
    if (location.startsWith(AppRoutes.analytics)) return 4;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
        break;
      case 1:
        context.go(AppRoutes.tournaments);
        break;
      case 2:
        context.go(AppRoutes.handicap);
        break;
      case 3:
        context.go(AppRoutes.milestones);
        break;
      case 4:
        context.go(AppRoutes.analytics);
        break;
    }
  }
}
