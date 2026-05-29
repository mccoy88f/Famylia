import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/app_state.dart';
import '../../core/session/family_context.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _todos = TodoRepository();
  final _shopping = ShoppingRepository();
  final _deadlines = DeadlineRepository();
  int _openTodos = 0;
  int _uncheckedItems = 0;
  int _upcomingDeadlines = 0;
  bool _loading = true;
  bool _offline = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      _offline = !await _shopping.isOnline;
      final todos = await _todos.list(familyId);
      final open = todos.where((t) => t.status != TodoStatus.done).length;
      final upcoming = await _deadlines.upcoming(familyId, days: 30);
      var unchecked = 0;
      final lists = await _shopping.listLists(familyId);
      for (final list in lists) {
        if (list.id == null) continue;
        final detail = await _shopping.getList(list.id!);
        unchecked += detail.items.where((i) => !i.isChecked).length;
      }
      if (mounted) {
        setState(() {
          _openTodos = open;
          _uncheckedItems = unchecked;
          _upcomingDeadlines = upcoming.length;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final family = context.watch<FamilyContext>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(family.activeFamilyName ?? 'Famylia'),
        actions: [
          if (_offline)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(Icons.cloud_off, size: 20),
            ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'privacy') {
                if (context.mounted) context.push(AppRoutes.privacy);
                return;
              }
              if (value == 'logout') {
                await family.clear();
                await AuthRepository().signOut();
                if (context.mounted) context.go(AppRoutes.login);
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'privacy',
                child: Row(
                  children: [
                    Icon(Icons.shield_outlined),
                    SizedBox(width: 8),
                    Text('Privacy'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Esci'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Ciao, ${appState.userName ?? 'famiglia'}!',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else ...[
              _DashboardCard(
                icon: Icons.check_circle_outline,
                title: 'Task aperti',
                value: '$_openTodos',
                onTap: () => context.go(AppRoutes.todos),
              ),
              const SizedBox(height: 12),
              _DashboardCard(
                icon: Icons.shopping_cart_outlined,
                title: 'Da comprare',
                value: '$_uncheckedItems',
                onTap: () => context.go(AppRoutes.shopping),
              ),
              const SizedBox(height: 12),
              _DashboardCard(
                icon: Icons.event_note_outlined,
                title: 'Scadenze (30 gg)',
                value: '$_upcomingDeadlines',
                onTap: () => context.push(AppRoutes.deadlines),
              ),
              const SizedBox(height: 24),
              Text(
                'Organizzazione',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _ModuleChip(
                    icon: Icons.payments_outlined,
                    label: 'Spese',
                    onTap: () => context.push(AppRoutes.expenses),
                  ),
                  _ModuleChip(
                    icon: Icons.calendar_month_outlined,
                    label: 'Calendario',
                    onTap: () => context.push(AppRoutes.calendar),
                  ),
                  _ModuleChip(
                    icon: Icons.forum_outlined,
                    label: 'Bacheca',
                    onTap: () => context.push(AppRoutes.board),
                  ),
                  _ModuleChip(
                    icon: Icons.folder_outlined,
                    label: 'Documenti',
                    onTap: () => context.push(AppRoutes.documents),
                  ),
                  _ModuleChip(
                    icon: Icons.restaurant_outlined,
                    label: 'Pasti',
                    onTap: () => context.push(AppRoutes.meals),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Sicurezza e privacy',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _ModuleChip(
                    icon: Icons.sos,
                    label: 'Emergenza',
                    onTap: () => context.push(AppRoutes.emergency),
                  ),
                  _ModuleChip(
                    icon: Icons.location_on_outlined,
                    label: 'Posizione',
                    onTap: () => context.push(AppRoutes.location),
                  ),
                  _ModuleChip(
                    icon: Icons.shield_outlined,
                    label: 'Privacy',
                    onTap: () => context.push(AppRoutes.privacy),
                  ),
                  _ModuleChip(
                    icon: Icons.bar_chart_outlined,
                    label: 'Report',
                    onTap: () => context.push(AppRoutes.reports),
                  ),
                  _ModuleChip(
                    icon: Icons.emoji_events_outlined,
                    label: 'Classifica',
                    onTap: () => context.push(AppRoutes.leaderboard),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ModuleChip extends StatelessWidget {
  const _ModuleChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
