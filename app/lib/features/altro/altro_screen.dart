import 'dart:convert';
import 'dart:typed_data';

import 'package:famylia_client/famylia_client.dart';
import 'package:file_picker/file_picker.dart';
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
import '../../core/session/app_state.dart';
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
        toolbarHeight: 0,
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
              const _FamilyMembersSection(),
              const SizedBox(height: 20),
              _ModulesSection(label: 'Strumenti', items: _aiItems),
              const SizedBox(height: 20),
              _ModulesSection(label: 'Casa & Famiglia', items: _homeItems),
            ],
          ),
        ),
        VerticalDivider(width: 1, color: shadTheme.colorScheme.border),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _ModulesSection(label: 'Sicurezza', items: _safetyItems),
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
        const _FamilyMembersSection(),
        const SizedBox(height: 20),
        _ModulesSection(label: 'Strumenti', items: _aiItems),
        const SizedBox(height: 20),
        _ModulesSection(label: 'Casa & Famiglia', items: _homeItems),
        const SizedBox(height: 20),
        _ModulesSection(label: 'Sicurezza', items: _safetyItems),
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

final _aiItems = [
  _Mod(Icons.auto_awesome_outlined, 'Importa con AI', 'Estrai attività da testo, foto, PDF', const Color(0xFF8B5CF6), AppRoutes.aiImport),
  _Mod(Icons.science_outlined, 'Admin AI', 'Test estrazione e configurazione', const Color(0xFF6366F1), AppRoutes.aiAdmin),
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
          ShadButton.ghost(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: code));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Codice copiato'), duration: Duration(seconds: 2)),
              );
            },
            child: const Text('Copia codice'),
          ),
          ShadButton(onPressed: () => Navigator.pop(ctx), child: const Text('Chiudi')),
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

  Future<void> _editFamilyName(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final ctrl = TextEditingController(
      text: context.read<FamilyContext>().activeFamilyName ?? '',
    );
    final shadTheme = ShadTheme.of(context);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: shadTheme.colorScheme.background,
        title: Text('Modifica nome famiglia', style: shadTheme.textTheme.h4),
        content: ShadInput(controller: ctrl, placeholder: const Text('Nome famiglia')),
        actions: [
          ShadButton.ghost(onPressed: () => Navigator.pop(ctx), child: const Text('Annulla')),
          ShadButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('Salva'),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (newName == null || newName.isEmpty) return;
    try {
      await _repo.updateFamilyName(familyId, newName);
      if (mounted) context.read<FamilyContext>().setActiveFamily(id: familyId, name: newName);
    } catch (_) {}
  }

  Uint8List? _memberPhotoBytes(int userId) {
    try {
      final memberPhotos = _familySettings['memberPhotos'] as Map<String, dynamic>?;
      final b64 = memberPhotos?['$userId'] as String?;
      if (b64 != null) return base64Decode(b64);
    } catch (_) {}
    return null;
  }

  Future<void> _pickCoverImage(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    if (bytes.lengthInBytes > 800 * 1024) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Immagine troppo grande (max 800 KB)'), backgroundColor: Colors.red),
        );
      }
      return;
    }
    final settings = Map<String, dynamic>.from(_familySettings);
    settings['coverImageB64'] = base64Encode(bytes);
    try {
      await _repo.updateFamilySettings(familyId, jsonEncode(settings));
      if (mounted) setState(() { _coverImageBytes = bytes; _familySettings = settings; });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore nel salvataggio: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final family = context.watch<FamilyContext>();
    final myUserId = context.watch<AppState>().signedInUser?.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Label('Famiglia · ${family.activeFamilyName ?? ''}'),
        const SizedBox(height: 8),
        // ── Family cover mini-banner ─────────────────────────────────────
        GestureDetector(
          onTap: () => _pickCoverImage(context),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              color: shadTheme.colorScheme.muted,
              image: _coverImageBytes != null
                  ? DecorationImage(image: MemoryImage(_coverImageBytes!), fit: BoxFit.cover)
                  : null,
            ),
            child: Stack(
              children: [
                if (_coverImageBytes == null)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_photo_alternate_outlined, size: 28, color: shadTheme.colorScheme.mutedForeground),
                        const SizedBox(height: 4),
                        Text('Aggiungi foto di copertina', style: shadTheme.textTheme.muted.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                Positioned(
                  bottom: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Text('Modifica', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  _MemberTile(
                    member: _members[i],
                    shadTheme: shadTheme,
                    index: i,
                    myUserId: myUserId,
                    familySettings: _familySettings,
                    initialPhotoBytes: _memberPhotoBytes(_members[i].userId),
                    onSettingsUpdated: (s) => setState(() => _familySettings = s),
                  ),
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

class _MemberTile extends StatefulWidget {
  const _MemberTile({required this.member, required this.shadTheme, this.index = 0, this.myUserId, this.initialPhotoBytes, this.familySettings, this.onSettingsUpdated});
  final FamilyMemberInfo member;
  final ShadThemeData shadTheme;
  final int index;
  final int? myUserId;
  final Uint8List? initialPhotoBytes;
  final Map<String, dynamic>? familySettings;
  final void Function(Map<String, dynamic>)? onSettingsUpdated;

  @override
  State<_MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<_MemberTile> {
  static const _colors = [
    Color(0xFF6366F1), Color(0xFF10B981), Color(0xFFF59E0B),
    Color(0xFFEF4444), Color(0xFF14B8A6), Color(0xFF8B5CF6),
  ];

  Uint8List? _photoBytes;
  static final Map<int, Uint8List> _photoCache = {};

  @override
  void initState() {
    super.initState();
    final cached = _photoCache[widget.member.userId];
    if (cached != null) {
      _photoBytes = cached;
    } else if (widget.initialPhotoBytes != null) {
      _photoBytes = widget.initialPhotoBytes;
      _photoCache[widget.member.userId] = widget.initialPhotoBytes!;
    }
  }

  Color get _color => widget.member.role == FamilyRole.admin
      ? widget.shadTheme.colorScheme.primary
      : widget.member.role == FamilyRole.guest
          ? widget.shadTheme.colorScheme.mutedForeground
          : _colors[widget.index % _colors.length];

  String _roleLabel(FamilyRole role) => switch (role) {
        FamilyRole.admin => 'Admin',
        FamilyRole.guest => 'Ospite',
        _ => 'Membro',
      };

  bool get _isMe => widget.myUserId == widget.member.userId;

  String _ageLabelFor(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) age--;
    if (age < 14) return '$age anni · < 14 (posizione su richiesta)';
    if (age < 18) return '$age anni · 14–17 (notifica "dove sei?")';
    return '$age anni · adulto';
  }

  Future<void> _pickBirthDate(BuildContext context) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final now = DateTime.now();
    final initial = widget.member.birthDate ?? DateTime(now.year - 10);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1940),
      lastDate: now,
      helpText: 'Data di nascita',
    );
    if (picked == null) return;
    try {
      await FamilyRepository().updateMemberBirthDate(familyId, widget.member.userId, picked);
      if (mounted) setState(() {});
    } catch (_) {}
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
    if (result == null || result.files.isEmpty) return;
    final bytes = result.files.first.bytes;
    if (bytes == null) return;
    if (bytes.lengthInBytes > 400 * 1024) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Immagine troppo grande (max 400 KB)'), backgroundColor: Colors.red),
        );
      }
      return;
    }
    final familyId = context.activeFamilyId;
    if (familyId != null) {
      final settings = Map<String, dynamic>.from(widget.familySettings ?? {});
      final memberPhotos = Map<String, dynamic>.from(settings['memberPhotos'] as Map<String, dynamic>? ?? {});
      memberPhotos['${widget.member.userId}'] = base64Encode(bytes);
      settings['memberPhotos'] = memberPhotos;
      try {
        await FamilyRepository().updateFamilySettings(familyId, jsonEncode(settings));
        widget.onSettingsUpdated?.call(settings);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Errore nel salvataggio foto: $e'), backgroundColor: Colors.red),
          );
        }
        return;
      }
    }
    _photoCache[widget.member.userId] = bytes;
    if (mounted) setState(() => _photoBytes = bytes);
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: _isMe ? _pickPhoto : null,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: color.withValues(alpha: 0.15),
                  backgroundImage: _photoBytes != null ? MemoryImage(_photoBytes!) : null,
                  child: _photoBytes == null
                      ? Text(
                          widget.member.displayName[0].toUpperCase(),
                          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 18),
                        )
                      : null,
                ),
                if (_isMe)
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 18, height: 18,
                      decoration: BoxDecoration(
                        color: widget.shadTheme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: widget.shadTheme.colorScheme.background, width: 1.5),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 10),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.member.displayName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                if (widget.member.birthDate != null)
                  GestureDetector(
                    onTap: _isMe ? () => _pickBirthDate(context) : null,
                    child: Text(
                      _ageLabelFor(widget.member.birthDate!),
                      style: TextStyle(fontSize: 11, color: widget.shadTheme.colorScheme.mutedForeground),
                    ),
                  )
                else if (_isMe)
                  GestureDetector(
                    onTap: () => _pickBirthDate(context),
                    child: Text(
                      'Aggiungi data di nascita',
                      style: TextStyle(fontSize: 11, color: widget.shadTheme.colorScheme.primary),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(_roleLabel(widget.member.role),
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
                        ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
                        ShadButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          backgroundColor: shadTheme.colorScheme.destructive,
                          foregroundColor: Colors.white,
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
