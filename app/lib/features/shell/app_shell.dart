import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'nuova_attivita_modal.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    _Tab('/feed', Icons.wb_sunny_outlined, Icons.wb_sunny, 'Oggi'),
    _Tab('/lista', Icons.task_alt_outlined, Icons.task_alt, 'Attività'),
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

// ── Mobile: bottom nav + FAB centrato rialzato ─────────────────────────────

class _NarrowShell extends StatelessWidget {
  const _NarrowShell({required this.child, required this.index, required this.tabs});

  final Widget child;
  final int index;
  final List<_Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final primary = shadTheme.colorScheme.primary;
    final navBg = shadTheme.colorScheme.background;

    return Scaffold(
      body: child,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.3),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => NuovaAttivitaModal.show(context),
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: shadTheme.colorScheme.primaryForeground,
          tooltip: 'Aggiungi',
          child: const Icon(Icons.add, size: 26),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: navBg,
        elevation: 0,
        padding: EdgeInsets.zero,
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                for (int i = 0; i < tabs.length; i++) ...[
                  if (i == 2) const SizedBox(width: 72),
                  Expanded(child: _NavItem(tab: tabs[i], selected: index == i, index: i, shadTheme: shadTheme)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.tab, required this.selected, required this.index, required this.shadTheme});
  final _Tab tab;
  final bool selected;
  final int index;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final color = selected ? shadTheme.colorScheme.primary : shadTheme.colorScheme.mutedForeground;

    return InkWell(
      onTap: () => context.go(tab.path),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(selected ? tab.selectedIcon : tab.icon, color: color, size: 22),
          const SizedBox(height: 2),
          Text(
            tab.label,
            style: TextStyle(fontSize: 11, color: color, fontWeight: selected ? FontWeight.w600 : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

// ── Tablet / Desktop: NavigationRail + FAB bottom-right ───────────────────

class _WideShell extends StatelessWidget {
  const _WideShell({required this.child, required this.index, required this.tabs});

  final Widget child;
  final int index;
  final List<_Tab> tabs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final extended = width >= 1200;
    final shadTheme = ShadTheme.of(context);
    final primary = shadTheme.colorScheme.primary;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => NuovaAttivitaModal.show(context),
        icon: const Icon(Icons.add),
        label: const Text('Aggiungi'),
        backgroundColor: primary,
        foregroundColor: shadTheme.colorScheme.primaryForeground,
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            selectedIndex: index,
            onDestinationSelected: (i) => context.go(tabs[i].path),
            backgroundColor: shadTheme.colorScheme.background,
            indicatorColor: primary.withValues(alpha: 0.12),
            minWidth: 72,
            minExtendedWidth: 200,
            selectedIconTheme: IconThemeData(color: primary),
            selectedLabelTextStyle: TextStyle(color: primary, fontWeight: FontWeight.w600),
            destinations: [
              for (final tab in tabs)
                NavigationRailDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: Text(tab.label),
                ),
            ],
          ),
          VerticalDivider(width: 1, color: shadTheme.colorScheme.border),
          Expanded(child: child),
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
