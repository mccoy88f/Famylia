import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class AltroScreen extends StatelessWidget {
  const AltroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;
    return Scaffold(
      appBar: AppBar(title: const Text('Altro')),
      body: isWide ? const _WideLayout() : const _NarrowLayout(),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _ModulesSection(label: 'Casa & Famiglia', items: _homeItems),
              const SizedBox(height: 20),
              _ModulesSection(label: 'Sicurezza', items: _safetyItems),
            ],
          ),
        ),
        VerticalDivider(width: 1, color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const _FamilyMembersSection(),
              const SizedBox(height: 20),
              _ModulesSection(label: 'Altro', items: _infoItems),
              const SizedBox(height: 20),
              const _SettingsSection(),
            ],
          ),
        ),
      ],
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
      children: [
        _ModulesSection(label: 'Casa & Famiglia', items: _homeItems),
        const SizedBox(height: 20),
        _ModulesSection(label: 'Sicurezza', items: _safetyItems),
        const SizedBox(height: 20),
        const _FamilyMembersSection(),
        const SizedBox(height: 20),
        _ModulesSection(label: 'Altro', items: _infoItems),
        const SizedBox(height: 20),
        const _SettingsSection(),
      ],
    );
  }
}

// ── Moduli ────────────────────────────────────────────────────────────────

final _homeItems = [
  _Mod(Icons.forum_outlined, 'Bacheca', 'Messaggi e sondaggi', Colors.teal, AppRoutes.board),
  _Mod(Icons.restaurant_outlined, 'Pasti', 'Ricettario e piano settimanale', Colors.orange, AppRoutes.meals),
  _Mod(Icons.favorite_outline, 'Salute', 'Visite e attività', Colors.red, AppRoutes.health),
  _Mod(Icons.folder_outlined, 'Documenti', 'File e ricevute', Colors.blue, AppRoutes.documents),
  _Mod(Icons.emoji_events_outlined, 'Classifica', 'Punti e gamification', Colors.amber, AppRoutes.leaderboard),
  _Mod(Icons.bar_chart_outlined, 'Report', 'Riepilogo e statistiche', Colors.indigo, AppRoutes.reports),
];

final _safetyItems = [
  _Mod(Icons.sos, 'Emergenza', 'Pulsante allarme', Colors.red, AppRoutes.emergency, urgent: true),
  _Mod(Icons.location_on_outlined, 'Posizione', 'Condivisione opt-in (24h)', Colors.green, AppRoutes.location),
];

final _infoItems = [
  _Mod(Icons.shield_outlined, 'Privacy & GDPR', 'Dati e consenso', Colors.blueGrey, AppRoutes.privacy),
];

// ── Sezione moduli ─────────────────────────────────────────────────────────

class _ModulesSection extends StatelessWidget {
  const _ModulesSection({required this.label, required this.items});
  final String label;
  final List<_Mod> items;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label(label),
        const SizedBox(height: 8),
        if (isWide)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3.0,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => _ModCard(mod: items[i]),
          )
        else
          for (final m in items) _ModCard(mod: m),
      ],
    );
  }
}

class _ModCard extends StatelessWidget {
  const _ModCard({required this.mod});
  final _Mod mod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isWide = MediaQuery.of(context).size.width >= 600;

    return Card(
      margin: isWide ? EdgeInsets.zero : const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: mod.urgent
            ? BorderSide(color: mod.color.withValues(alpha: 0.5), width: 1.5)
            : BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
      ),
      color: mod.urgent ? mod.color.withValues(alpha: 0.05) : null,
      child: InkWell(
        onTap: () => context.push(mod.route),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: mod.color.withValues(alpha: 0.12),
                child: Icon(mod.icon, color: mod.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(mod.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(mod.subtitle,
                        style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.55)),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurface.withValues(alpha: 0.3)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sezione famiglia (membri + invito) ────────────────────────────────────

class _FamilyMembersSection extends StatefulWidget {
  const _FamilyMembersSection();

  @override
  State<_FamilyMembersSection> createState() => _FamilyMembersSectionState();
}

class _FamilyMembersSectionState extends State<_FamilyMembersSection> {
  final _repo = FamilyRepository();
  List<FamilyMemberInfo> _members = [];
  String? _inviteCode;
  bool _loading = true;

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
      final family = await _repo.getFamily(familyId);
      final members = await _repo.listMembers(familyId);
      if (mounted) {
        setState(() {
          _members = members;
          _inviteCode = family.inviteCode;
        });
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final family = context.watch<FamilyContext>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label('Famiglia · ${family.activeFamilyName ?? ''}'),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              // Codice invito
              if (_inviteCode != null)
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: _inviteCode!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Codice copiato'), duration: Duration(seconds: 2)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined, color: scheme.primary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Codice invito', style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.55))),
                              const SizedBox(height: 2),
                              Text(
                                _inviteCode!,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: scheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.copy_outlined, size: 18, color: scheme.onSurface.withValues(alpha: 0.4)),
                      ],
                    ),
                  ),
                ),
              if (_inviteCode != null) Divider(height: 1, color: scheme.outline.withValues(alpha: 0.3)),
              // Membri
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                for (int i = 0; i < _members.length; i++) ...[
                  _MemberTile(member: _members[i]),
                  if (i < _members.length - 1)
                    Divider(height: 1, indent: 16, color: scheme.outline.withValues(alpha: 0.2)),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member});
  final FamilyMemberInfo member;

  Color _roleColor(FamilyRole role, ColorScheme s) => switch (role) {
        FamilyRole.admin => s.primary,
        FamilyRole.guest => s.outline,
        _ => s.secondary,
      };

  String _roleLabel(FamilyRole role) => switch (role) {
        FamilyRole.admin => 'Admin',
        FamilyRole.guest => 'Ospite',
        _ => 'Membro',
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = _roleColor(member.role, scheme);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Text(
              member.displayName[0].toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(member.displayName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(_roleLabel(member.role),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          ),
        ],
      ),
    );
  }
}

// ── Sezione impostazioni ──────────────────────────────────────────────────

class _SettingsSection extends StatelessWidget {
  const _SettingsSection();

  @override
  Widget build(BuildContext context) {
    final family = context.watch<FamilyContext>();
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label('Impostazioni'),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.palette_outlined, color: scheme.primary),
                title: const Text('Aspetto'),
                subtitle: const Text('Tema e colore accento', style: TextStyle(fontSize: 13)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.appearance),
              ),
              Divider(height: 1, color: scheme.outline.withValues(alpha: 0.25)),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Esci', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Esci da Famylia?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
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

// ── Helpers ───────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.7,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}

class _Mod {
  const _Mod(this.icon, this.label, this.subtitle, this.color, this.route, {this.urgent = false});
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final String route;
  final bool urgent;
}
