import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class AltroScreen extends StatelessWidget {
  const AltroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return Scaffold(
      appBar: AppBar(title: const Text('Altro')),
      body: isWide
          ? _WideLayout()
          : _NarrowLayout(),
    );
  }
}

class _WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Section(label: 'Casa & Famiglia', items: _homeItems),
              const SizedBox(height: 16),
              _Section(label: 'Sicurezza', items: _safetyItems),
            ],
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _Section(label: 'Informazioni', items: _infoItems),
              const SizedBox(height: 16),
              _SettingsSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        _Section(label: 'Casa & Famiglia', items: _homeItems),
        const SizedBox(height: 16),
        _Section(label: 'Sicurezza', items: _safetyItems),
        const SizedBox(height: 16),
        _Section(label: 'Informazioni', items: _infoItems),
        const SizedBox(height: 16),
        _SettingsSection(),
      ],
    );
  }
}

// ── Module definitions ────────────────────────────────────────────────────

final _homeItems = [
  _ModuleItem(
    icon: Icons.forum_outlined,
    label: 'Bacheca',
    subtitle: 'Messaggi e sondaggi',
    color: Colors.teal,
    route: AppRoutes.board,
  ),
  _ModuleItem(
    icon: Icons.restaurant_outlined,
    label: 'Pasti',
    subtitle: 'Ricettario e piano settimanale',
    color: Colors.orange,
    route: AppRoutes.meals,
  ),
  _ModuleItem(
    icon: Icons.favorite_outline,
    label: 'Salute',
    subtitle: 'Visite e attività',
    color: Colors.red,
    route: AppRoutes.health,
  ),
  _ModuleItem(
    icon: Icons.folder_outlined,
    label: 'Documenti',
    subtitle: 'File e ricevute',
    color: Colors.blue,
    route: AppRoutes.documents,
  ),
  _ModuleItem(
    icon: Icons.emoji_events_outlined,
    label: 'Classifica',
    subtitle: 'Punti e gamification',
    color: Colors.amber,
    route: AppRoutes.leaderboard,
  ),
  _ModuleItem(
    icon: Icons.bar_chart_outlined,
    label: 'Report',
    subtitle: 'Riepilogo e statistiche',
    color: Colors.indigo,
    route: AppRoutes.reports,
  ),
];

final _safetyItems = [
  _ModuleItem(
    icon: Icons.sos,
    label: 'Emergenza',
    subtitle: 'Pulsante allarme',
    color: Colors.red,
    route: AppRoutes.emergency,
    isUrgent: true,
  ),
  _ModuleItem(
    icon: Icons.location_on_outlined,
    label: 'Posizione',
    subtitle: 'Condivisione opt-in',
    color: Colors.green,
    route: AppRoutes.location,
  ),
];

final _infoItems = [
  _ModuleItem(
    icon: Icons.shield_outlined,
    label: 'Privacy',
    subtitle: 'Dati e GDPR',
    color: Colors.blueGrey,
    route: AppRoutes.privacy,
  ),
];

// ── Section widgets ───────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.items});
  final String label;
  final List<_ModuleItem> items;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isGrid = width >= 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  letterSpacing: 0.5,
                ),
          ),
        ),
        if (isGrid)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.8,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => _ModuleCard(item: items[i]),
          )
        else
          for (final item in items) _ModuleCard(item: item),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.item});
  final _ModuleItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 600;

    return Card(
      margin: isWide ? EdgeInsets.zero : const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: item.isUrgent
            ? BorderSide(color: item.color.withValues(alpha: 0.5), width: 1.5)
            : BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.4)),
      ),
      color: item.isUrgent ? item.color.withValues(alpha: 0.06) : null,
      child: InkWell(
        onTap: () => context.push(item.route),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: item.color.withValues(alpha: 0.12),
                child: Icon(item.icon, color: item.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.label,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      item.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final family = context.watch<FamilyContext>();
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Impostazioni',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: scheme.onSurface.withValues(alpha: 0.6),
              letterSpacing: 0.5,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.palette_outlined, color: scheme.primary),
                title: const Text('Aspetto'),
                subtitle: const Text('Tema e colore accento'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.appearance),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.shield_outlined, color: Colors.blueGrey),
                title: const Text('Privacy & GDPR'),
                subtitle: const Text('Dati personali e consenso'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.privacy),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.logout, color: scheme.error),
                title: Text('Esci', style: TextStyle(color: scheme.error)),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Esci da Famylia?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Annulla'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: FilledButton.styleFrom(backgroundColor: scheme.error),
                          child: const Text('Esci'),
                        ),
                      ],
                    ),
                  );
                  if (confirm != true) return;
                  await family.clear();
                  await AuthRepository().signOut();
                  if (context.mounted) context.go(AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────

class _ModuleItem {
  const _ModuleItem({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.route,
    this.isUrgent = false,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final String route;
  final bool isUrgent;
}
