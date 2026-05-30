import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'quick_add_modal.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    _Tab('/feed', Icons.wb_sunny_outlined, Icons.wb_sunny, 'Oggi'),
    _Tab('/lista', Icons.list_alt_outlined, Icons.list_alt, 'Lista'),
    _Tab('/agenda', Icons.calendar_month_outlined, Icons.calendar_month, 'Agenda'),
    _Tab('/altro', Icons.apps_outlined, Icons.apps, 'Altro'),
  ];

  int _indexForLocation(String location) {
    if (location.startsWith('/lista')) return 1;
    if (location.startsWith('/agenda')) return 2;
    if (location.startsWith('/altro')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexForLocation(location);
    final width = MediaQuery.of(context).size.width;

    if (width >= 600) {
      return _WideShell(child: child, index: index, tabs: _tabs);
    }
    return _NarrowShell(child: child, index: index, tabs: _tabs);
  }
}

// ── Mobile: bottom navigation + centered FAB ───────────────────────────────

class _NarrowShell extends StatelessWidget {
  const _NarrowShell({
    required this.child,
    required this.index,
    required this.tabs,
  });

  final Widget child;
  final int index;
  final List<_Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: _AddFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(tabs[i].path),
        destinations: [
          for (final tab in tabs)
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

// ── Tablet / Desktop: side navigation rail ────────────────────────────────

class _WideShell extends StatelessWidget {
  const _WideShell({
    required this.child,
    required this.index,
    required this.tabs,
  });

  final Widget child;
  final int index;
  final List<_Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final extended = width >= 1200;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            selectedIndex: index,
            onDestinationSelected: (i) => context.go(tabs[i].path),
            backgroundColor: Theme.of(context).navigationBarTheme.backgroundColor,
            indicatorColor: scheme.primary.withValues(alpha: 0.18),
            leading: _RailAddButton(extended: extended),
            destinations: [
              for (final tab in tabs)
                NavigationRailDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: Text(tab.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _AddFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => QuickAddModal.show(context),
      tooltip: 'Aggiungi',
      child: const Icon(Icons.add),
    );
  }
}

class _RailAddButton extends StatelessWidget {
  const _RailAddButton({required this.extended});
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: extended
          ? FilledButton.icon(
              onPressed: () => QuickAddModal.show(context),
              icon: const Icon(Icons.add),
              label: const Text('Aggiungi'),
            )
          : FloatingActionButton.small(
              onPressed: () => QuickAddModal.show(context),
              tooltip: 'Aggiungi',
              elevation: 0,
              backgroundColor: scheme.primary.withValues(alpha: 0.15),
              foregroundColor: scheme.primary,
              child: const Icon(Icons.add),
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
