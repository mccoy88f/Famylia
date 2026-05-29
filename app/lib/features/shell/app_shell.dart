import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    _Tab('/home', Icons.home_outlined, Icons.home, 'Home'),
    _Tab('/todos', Icons.check_circle_outline, Icons.check_circle, 'Todo'),
    _Tab('/shopping', Icons.shopping_cart_outlined, Icons.shopping_cart, 'Spesa'),
  ];

  int _indexForLocation(String location) {
    if (location.startsWith('/todos')) return 1;
    if (location.startsWith('/shopping')) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexForLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

class _Tab {
  const _Tab(this.path, this.icon, this.selectedIcon, this.label);
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
