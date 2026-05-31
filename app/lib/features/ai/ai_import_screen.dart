import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/ai_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../shell/nuova_attivita_modal.dart';

class AiImportScreen extends StatefulWidget {
  const AiImportScreen({super.key});

  @override
  State<AiImportScreen> createState() => _AiImportScreenState();
}

class _AiImportScreenState extends State<AiImportScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _repo = AiRepository();
  final _textCtrl = TextEditingController();

  bool _loading = false;
  String? _error;
  AiExtractionResult? _result;

  // Files/images attached
  final List<_Attachment> _attachments = [];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _pasteClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.trim().isNotEmpty) {
      _textCtrl.text = data.text!.trim();
      setState(() => _error = null);
    } else {
      setState(() => _error = 'Clipboard vuota o non contiene testo.');
    }
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
      withData: true,
    );
    if (result == null) return;
    setState(() {
      for (final file in result.files) {
        if (file.bytes == null) continue;
        final mime = _mimeFromExtension(file.extension ?? '');
        _attachments.add(_Attachment(
          name: file.name,
          base64: base64Encode(file.bytes!),
          mimeType: mime,
        ));
      }
      _error = null;
    });
  }

  String _mimeFromExtension(String ext) => switch (ext.toLowerCase()) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        'webp' => 'image/webp',
        'pdf' => 'application/pdf',
        _ => 'image/jpeg',
      };

  Future<void> _extract() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;

    final text = _textCtrl.text.trim();
    if (text.isEmpty && _attachments.isEmpty) {
      setState(() => _error = 'Aggiungi del testo o almeno un file.');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });

    try {
      final result = await _repo.extractActivity(
        familyId,
        text: text.isEmpty ? null : text,
        base64Images: _attachments.isEmpty ? null : _attachments.map((a) => a.base64).toList(),
        mimeTypes: _attachments.isEmpty ? null : _attachments.map((a) => a.mimeType).toList(),
      );
      if (mounted) setState(() => _result = result);
    } catch (e) {
      if (mounted) setState(() => _error = _repo.errorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _conferma() {
    if (_result == null) return;
    Navigator.pop(context);
    NuovaAttivitaModal.showPrefilled(context, _result!);
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome_outlined, size: 18, color: shadTheme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Importa con AI', style: shadTheme.textTheme.h4),
          ],
        ),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(icon: Icon(Icons.content_paste_outlined, size: 18), text: 'Testo'),
            Tab(icon: Icon(Icons.image_outlined, size: 18), text: 'File'),
            Tab(icon: Icon(Icons.mail_outline, size: 18), text: 'Gmail'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _TextTab(
                  ctrl: _textCtrl,
                  onPaste: _pasteClipboard,
                  onChanged: () => setState(() {}),
                  shadTheme: shadTheme,
                ),
                _FileTab(
                  attachments: _attachments,
                  onPick: _pickFiles,
                  onRemove: (i) => setState(() => _attachments.removeAt(i)),
                  shadTheme: shadTheme,
                ),
                _GmailTab(shadTheme: shadTheme, onTextImported: (t) {
                  _textCtrl.text = t;
                  _tabs.animateTo(0);
                  setState(() {});
                }),
              ],
            ),
          ),
          if (_error != null)
            Container(
              width: double.infinity,
              color: shadTheme.colorScheme.destructive.withValues(alpha: 0.1),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(_error!, style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 13)),
            ),
          if (_result != null) _ResultCard(result: _result!, shadTheme: shadTheme),
          _BottomBar(
            loading: _loading,
            hasResult: _result != null,
            canExtract: _textCtrl.text.trim().isNotEmpty || _attachments.isNotEmpty,
            onExtract: _extract,
            onConferma: _conferma,
            onReset: () => setState(() { _result = null; _error = null; }),
            shadTheme: shadTheme,
          ),
        ],
      ),
    );
  }
}

// ── Tab testo ─────────────────────────────────────────────────────────────

class _TextTab extends StatelessWidget {
  const _TextTab({required this.ctrl, required this.onPaste, required this.onChanged, required this.shadTheme});
  final TextEditingController ctrl;
  final VoidCallback onPaste;
  final VoidCallback onChanged;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Incolla testo da qualsiasi fonte: email, SMS, nota, messaggio...',
                  style: shadTheme.textTheme.muted,
                ),
              ),
              ShadButton.outline(
                onPressed: onPaste,
                size: ShadButtonSize.sm,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.content_paste_outlined, size: 14),
                    SizedBox(width: 6),
                    Text('Incolla'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ShadInput(
              controller: ctrl,
              placeholder: const Text('Incolla qui il testo da analizzare…'),
              maxLines: 999,
              onChanged: (_) => onChanged(),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab file ──────────────────────────────────────────────────────────────

class _FileTab extends StatelessWidget {
  const _FileTab({required this.attachments, required this.onPick, required this.onRemove, required this.shadTheme});
  final List<_Attachment> attachments;
  final VoidCallback onPick;
  final void Function(int) onRemove;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Carica screenshot, foto di bollette o documenti PDF.', style: shadTheme.textTheme.muted),
          const SizedBox(height: 16),
          ShadButton.outline(
            onPressed: onPick,
            width: double.infinity,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.upload_file_outlined, size: 18),
                SizedBox(width: 8),
                Text('Scegli file (JPG, PNG, PDF)'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (attachments.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.image_search_outlined, size: 48, color: shadTheme.colorScheme.mutedForeground),
                    const SizedBox(height: 12),
                    Text('Nessun file caricato', style: shadTheme.textTheme.muted),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: attachments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (_, i) {
                  final a = attachments[i];
                  return ShadCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          a.mimeType.startsWith('image') ? Icons.image_outlined : Icons.picture_as_pdf_outlined,
                          size: 20,
                          color: shadTheme.colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(a.name, style: shadTheme.textTheme.small)),
                        ShadButton.ghost(
                          size: ShadButtonSize.icon,
                          onPressed: () => onRemove(i),
                          child: Icon(Icons.close, size: 16, color: shadTheme.colorScheme.mutedForeground),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ── Tab Gmail ─────────────────────────────────────────────────────────────

class _GmailTab extends StatelessWidget {
  const _GmailTab({required this.shadTheme, required this.onTextImported});
  final ShadThemeData shadTheme;
  final void Function(String) onTextImported;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outlined, size: 56, color: shadTheme.colorScheme.mutedForeground),
          const SizedBox(height: 20),
          Text(
            'Integrazione Gmail',
            style: shadTheme.textTheme.h4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Connetti il tuo account Google per leggere email e rilevare automaticamente bollette, appuntamenti e spese.',
            style: shadTheme.textTheme.muted,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ShadCard(
            backgroundColor: shadTheme.colorScheme.muted.withValues(alpha: 0.4),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 14, color: shadTheme.colorScheme.mutedForeground),
                    const SizedBox(width: 6),
                    Text('Configurazione richiesta', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '1. Crea un progetto su Google Cloud Console\n'
                  '2. Abilita Gmail API\n'
                  '3. Configura OAuth 2.0 con scope gmail.readonly\n'
                  '4. Aggiungi il client ID nelle impostazioni',
                  style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ShadButton(
            onPressed: null,
            width: double.infinity,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.login_outlined, size: 18),
                SizedBox(width: 8),
                Text('Connetti Gmail'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('Disponibile dopo la configurazione OAuth', style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

// ── Result card ───────────────────────────────────────────────────────────

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result, required this.shadTheme});
  final AiExtractionResult result;
  final ShadThemeData shadTheme;

  Color get _confidenzaColor => result.confidenza >= 0.75
      ? const Color(0xFF10B981)
      : result.confidenza >= 0.4
          ? const Color(0xFFF59E0B)
          : const Color(0xFFEF4444);

  String get _tipoLabel => switch (result.tipo) {
        'appuntamento' => '📅 Appuntamento',
        'spesa' => '💶 Spesa',
        'scadenza' => '⏰ Scadenza',
        'acquisto' => '🛒 Acquisto',
        _ => '✅ Task',
      };

  @override
  Widget build(BuildContext context) {
    final c = _confidenzaColor;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ShadCard(
        padding: const EdgeInsets.all(16),
        backgroundColor: shadTheme.colorScheme.primary.withValues(alpha: 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, size: 16, color: shadTheme.colorScheme.primary),
                const SizedBox(width: 6),
                Text('Attività rilevata', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600, color: shadTheme.colorScheme.primary)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    '${(result.confidenza * 100).round()}% confidenza',
                    style: TextStyle(fontSize: 11, color: c, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _Row(label: 'Tipo', value: _tipoLabel, shadTheme: shadTheme),
            _Row(label: 'Titolo', value: result.titolo, shadTheme: shadTheme),
            if (result.descrizione != null && result.descrizione!.isNotEmpty)
              _Row(label: 'Note', value: result.descrizione!, shadTheme: shadTheme),
            if (result.importo != null)
              _Row(label: 'Importo', value: '€ ${result.importo!.toStringAsFixed(2)}', shadTheme: shadTheme),
            if (result.quando != null)
              _Row(label: 'Data', value: _fmtDate(result.quando!), shadTheme: shadTheme),
            const SizedBox(height: 8),
            Text(result.motivazione, style: shadTheme.textTheme.muted.copyWith(fontSize: 11, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}  ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, required this.shadTheme});
  final String label;
  final String value;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(label, style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground)),
          ),
          Expanded(child: Text(value, style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

// ── Bottom bar ────────────────────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.loading,
    required this.hasResult,
    required this.canExtract,
    required this.onExtract,
    required this.onConferma,
    required this.onReset,
    required this.shadTheme,
  });
  final bool loading;
  final bool hasResult;
  final bool canExtract;
  final VoidCallback onExtract;
  final VoidCallback onConferma;
  final VoidCallback onReset;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: shadTheme.colorScheme.background,
        border: Border(top: BorderSide(color: shadTheme.colorScheme.border)),
      ),
      child: Row(
        children: [
          if (hasResult) ...[
            Expanded(
              child: ShadButton.outline(
                onPressed: onReset,
                child: const Text('Rianalizza'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ShadButton(
                onPressed: onConferma,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 16),
                    SizedBox(width: 6),
                    Text('Continua'),
                  ],
                ),
              ),
            ),
          ] else
            Expanded(
              child: ShadButton(
                onPressed: (canExtract && !loading) ? onExtract : null,
                child: loading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome_outlined, size: 16),
                          SizedBox(width: 8),
                          Text('Analizza con AI'),
                        ],
                      ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Models ────────────────────────────────────────────────────────────────

class _Attachment {
  const _Attachment({required this.name, required this.base64, required this.mimeType});
  final String name;
  final String base64;
  final String mimeType;
}
