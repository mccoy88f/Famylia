import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class AltroScreen extends StatelessWidget {
  const AltroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final isWide = MediaQuery.of(context).size.width >= 900;
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Altro', style: shadTheme.textTheme.h4),
      ),
      body: isWide ? const _WideLayout() : const _NarrowLayout(),
    );
  }
}

class _WideLayout extends StatelessWidget {
  const _WideLayout();

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
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
        VerticalDivider(width: 1, color: shadTheme.colorScheme.border),
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
  _Mod(Icons.forum_outlined, 'Bacheca', 'Messaggi e sondaggi', const Color(0xFF14B8A6), AppRoutes.board),
  _Mod(Icons.restaurant_outlined, 'Pasti', 'Ricettario e piano settimanale', const Color(0xFFF59E0B), AppRoutes.meals),
  _Mod(Icons.favorite_outline, 'Salute', 'Visite e attività', const Color(0xFFEF4444), AppRoutes.health),
  _Mod(Icons.folder_outlined, 'Documenti', 'File e ricevute', const Color(0xFF3B82F6), AppRoutes.documents),
  _Mod(Icons.emoji_events_outlined, 'Classifica', 'Punti e gamification', const Color(0xFFF59E0B), AppRoutes.leaderboard),
  _Mod(Icons.bar_chart_outlined, 'Report', 'Riepilogo e statistiche', const Color(0xFF6366F1), AppRoutes.reports),
];

final _safetyItems = [
  _Mod(Icons.sos, 'Emergenza', 'Pulsante allarme', const Color(0xFFEF4444), AppRoutes.emergency, urgent: true),
  _Mod(Icons.location_on_outlined, 'Posizione', 'Condivisione opt-in (24h)', const Color(0xFF10B981), AppRoutes.location),
];

final _infoItems = [
  _Mod(Icons.shield_outlined, 'Privacy & GDPR', 'Dati e consenso', const Color(0xFF64748B), AppRoutes.privacy),
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
          for (final m in items) Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _ModCard(mod: m),
          ),
      ],
    );
  }
}

class _ModCard extends StatelessWidget {
  const _ModCard({required this.mod});
  final _Mod mod;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);

    return ShadCard(
      padding: EdgeInsets.zero,
      backgroundColor: mod.urgent ? mod.color.withValues(alpha: 0.04) : null,
      border: mod.urgent
          ? Border.all(color: mod.color.withValues(alpha: 0.4), width: 1.5)
          : null,
      child: InkWell(
        onTap: () => context.push(mod.route),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: mod.color.withValues(alpha: 0.12),
                child: Icon(mod.icon, color: mod.color, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(mod.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(mod.subtitle,
                        style: shadTheme.textTheme.muted.copyWith(fontSize: 12),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: shadTheme.colorScheme.mutedForeground, size: 18),
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

  void _showQr(BuildContext context, String code) {
    final shadTheme = ShadTheme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: shadTheme.colorScheme.background,
        title: Text('QR Code invito', textAlign: TextAlign.center, style: shadTheme.textTheme.h4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImageView(
                data: 'famylia://join/$code',
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 3,
                color: shadTheme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Fai scansionare questo QR o condividi il codice',
              textAlign: TextAlign.center,
              style: shadTheme.textTheme.muted,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Codice copiato'), duration: Duration(seconds: 2)),
              );
            },
            child: const Text('Copia codice'),
          ),
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Chiudi')),
        ],
      ),
    );
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
    final shadTheme = ShadTheme.of(context);
    final family = context.watch<FamilyContext>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label('Famiglia · ${family.activeFamilyName ?? ''}'),
        const SizedBox(height: 8),
        ShadCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              if (_inviteCode != null)
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: _inviteCode!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Codice copiato'), duration: Duration(seconds: 2)),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
                    child: Row(
                      children: [
                        Icon(Icons.share_outlined, color: shadTheme.colorScheme.primary, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Codice invito', style: shadTheme.textTheme.muted.copyWith(fontSize: 12)),
                              const SizedBox(height: 2),
                              Text(
                                _inviteCode!,
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: shadTheme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ShadButton.ghost(
                          onPressed: () => _showQr(context, _inviteCode!),
                          size: ShadButtonSize.icon,
                          child: Icon(Icons.qr_code_rounded, size: 18, color: shadTheme.colorScheme.primary),
                        ),
                        Icon(Icons.copy_outlined, size: 16, color: shadTheme.colorScheme.mutedForeground),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              if (_inviteCode != null) Divider(height: 1, color: shadTheme.colorScheme.border),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                for (int i = 0; i < _members.length; i++) ...[
                  _MemberTile(member: _members[i], shadTheme: shadTheme),
                  if (i < _members.length - 1)
                    Divider(height: 1, indent: 16, color: shadTheme.colorScheme.border),
                ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MemberTile extends StatelessWidget {
  const _MemberTile({required this.member, required this.shadTheme});
  final FamilyMemberInfo member;
  final ShadThemeData shadTheme;

  Color _roleColor(FamilyRole role) => switch (role) {
        FamilyRole.admin => shadTheme.colorScheme.primary,
        FamilyRole.guest => shadTheme.colorScheme.mutedForeground,
        _ => const Color(0xFF8B5CF6),
      };

  String _roleLabel(FamilyRole role) => switch (role) {
        FamilyRole.admin => 'Admin',
        FamilyRole.guest => 'Ospite',
        _ => 'Membro',
      };

  @override
  Widget build(BuildContext context) {
    final color = _roleColor(member.role);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: color.withValues(alpha: 0.12),
            child: Text(
              member.displayName[0].toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(member.displayName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
    final shadTheme = ShadTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label('Impostazioni'),
        const SizedBox(height: 8),
        ShadCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.palette_outlined, color: shadTheme.colorScheme.primary, size: 20),
                title: const Text('Aspetto'),
                subtitle: Text('Tema e colore accento', style: shadTheme.textTheme.muted.copyWith(fontSize: 12)),
                trailing: Icon(Icons.chevron_right, size: 18, color: shadTheme.colorScheme.mutedForeground),
                onTap: () => context.push(AppRoutes.appearance),
              ),
              Divider(height: 1, color: shadTheme.colorScheme.border),
              ListTile(
                leading: Icon(Icons.logout, color: shadTheme.colorScheme.destructive, size: 20),
                title: Text('Esci', style: TextStyle(color: shadTheme.colorScheme.destructive)),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: shadTheme.colorScheme.background,
                      title: Text('Esci da Famylia?', style: shadTheme.textTheme.h4),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          style: FilledButton.styleFrom(backgroundColor: shadTheme.colorScheme.destructive),
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
      style: ShadTheme.of(context).textTheme.muted.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.7,
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
