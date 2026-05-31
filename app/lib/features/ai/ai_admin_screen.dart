import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/ai_repository.dart';
import '../../core/extensions/context_extensions.dart';

class AiAdminScreen extends StatefulWidget {
  const AiAdminScreen({super.key});

  @override
  State<AiAdminScreen> createState() => _AiAdminScreenState();
}

class _AiAdminScreenState extends State<AiAdminScreen> {
  final _repo = AiRepository();

  // Config section
  final _keyCtrl = TextEditingController();
  final _modelCtrl = TextEditingController(text: 'google/gemini-2.5-flash-preview');
  bool _loadingConfig = true;
  bool _savingConfig = false;
  bool _obscureKey = true;
  String? _keyPreview;
  bool _hasKey = false;
  String? _configError;
  String? _configSuccess;

  // Test section
  final _textCtrl = TextEditingController();
  final _testModelCtrl = TextEditingController();
  bool _testing = false;
  String? _testError;
  String? _rawResult;
  AiExtractionResult? _result;
  final List<_Attachment> _attachments = [];

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  @override
  void dispose() {
    _keyCtrl.dispose();
    _modelCtrl.dispose();
    _textCtrl.dispose();
    _testModelCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadConfig() async {
    setState(() { _loadingConfig = true; _configError = null; });
    try {
      final cfg = await _repo.getAiConfig();
      if (mounted) {
        setState(() {
          _hasKey = cfg['hasKey'] as bool? ?? false;
          _keyPreview = cfg['keyPreview'] as String?;
          _modelCtrl.text = cfg['defaultModel'] as String? ?? 'google/gemini-2.5-flash-preview';
          _testModelCtrl.text = _modelCtrl.text;
          _loadingConfig = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _loadingConfig = false; _configError = _repo.errorMessage(e); });
    }
  }

  Future<void> _saveConfig() async {
    final key = _keyCtrl.text.trim();
    final model = _modelCtrl.text.trim();
    if (model.isEmpty) {
      setState(() => _configError = 'Il modello non può essere vuoto.');
      return;
    }
    setState(() { _savingConfig = true; _configError = null; _configSuccess = null; });
    try {
      await _repo.saveAiConfig(key.isEmpty ? '' : key, model);
      if (mounted) {
        _keyCtrl.clear();
        setState(() { _savingConfig = false; _configSuccess = 'Configurazione salvata.'; });
        await _loadConfig();
      }
    } catch (e) {
      if (mounted) setState(() { _savingConfig = false; _configError = _repo.errorMessage(e); });
    }
  }

  Future<void> _pasteClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) setState(() => _textCtrl.text = data!.text!);
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
      for (final f in result.files) {
        if (f.bytes == null) continue;
        _attachments.add(_Attachment(name: f.name, base64: base64Encode(f.bytes!), mimeType: _mimeFromExt(f.extension ?? '')));
      }
    });
  }

  String _mimeFromExt(String ext) => switch (ext.toLowerCase()) {
        'jpg' || 'jpeg' => 'image/jpeg',
        'png' => 'image/png',
        'webp' => 'image/webp',
        'pdf' => 'application/pdf',
        _ => 'image/jpeg',
      };

  Future<void> _test() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final text = _textCtrl.text.trim();
    if (text.isEmpty && _attachments.isEmpty) {
      setState(() => _testError = 'Inserisci testo o file.');
      return;
    }
    setState(() { _testing = true; _testError = null; _result = null; _rawResult = null; });
    try {
      final result = await _repo.extractActivity(
        familyId,
        text: text.isEmpty ? null : text,
        base64Images: _attachments.isEmpty ? null : _attachments.map((a) => a.base64).toList(),
        mimeTypes: _attachments.isEmpty ? null : _attachments.map((a) => a.mimeType).toList(),
        model: _testModelCtrl.text.trim().isEmpty ? null : _testModelCtrl.text.trim(),
      );
      if (mounted) {
        setState(() {
          _result = result;
          _rawResult = const JsonEncoder.withIndent('  ').convert(result.raw);
          _testing = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() { _testError = _repo.errorMessage(e); _testing = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Admin AI', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Config section ──────────────────────────────────────────
              _SectionHeader(icon: Icons.settings_outlined, label: 'Configurazione OpenRouter', shadTheme: shadTheme),
              const SizedBox(height: 16),
              if (_loadingConfig)
                const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()))
              else ...[
                // Status
                _StatusChip(hasKey: _hasKey, keyPreview: _keyPreview, shadTheme: shadTheme),
                const SizedBox(height: 16),
                // API key input
                Text('Nuova API key', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ShadInput(
                        controller: _keyCtrl,
                        placeholder: Text(_hasKey ? 'Lascia vuoto per mantenere la chiave attuale' : 'sk-or-v1-...'),
                        obscureText: _obscureKey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ShadButton.ghost(
                      size: ShadButtonSize.icon,
                      onPressed: () => setState(() => _obscureKey = !_obscureKey),
                      child: Icon(_obscureKey ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Ottieni la chiave su openrouter.ai/keys', style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
                const SizedBox(height: 16),
                // Model
                Text('Modello predefinito', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                ShadInput(
                  controller: _modelCtrl,
                  placeholder: const Text('google/gemini-2.5-flash-preview'),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(Icons.memory_outlined, size: 16, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Esempi:\n'
                  '• google/gemini-2.5-flash-preview  (vision, veloce)\n'
                  '• anthropic/claude-3.5-haiku  (testo, economico)\n'
                  '• meta-llama/llama-3.2-11b-vision-instruct:free  (gratuito)',
                  style: shadTheme.textTheme.muted.copyWith(fontSize: 11),
                ),
                const SizedBox(height: 16),
                if (_configError != null) ...[
                  _InlineError(message: _configError!, shadTheme: shadTheme),
                  const SizedBox(height: 12),
                ],
                if (_configSuccess != null) ...[
                  _InlineSuccess(message: _configSuccess!, shadTheme: shadTheme),
                  const SizedBox(height: 12),
                ],
                ShadButton(
                  onPressed: _savingConfig ? null : _saveConfig,
                  width: double.infinity,
                  child: _savingConfig
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Salva configurazione'),
                ),
              ],

              const SizedBox(height: 32),
              Divider(color: shadTheme.colorScheme.border),
              const SizedBox(height: 24),

              // ── Test section ────────────────────────────────────────────
              _SectionHeader(icon: Icons.science_outlined, label: 'Test estrazione', shadTheme: shadTheme),
              const SizedBox(height: 16),
              // Model override for test
              Text('Modello per questo test (opzionale)', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              ShadInput(
                controller: _testModelCtrl,
                placeholder: const Text('Lascia vuoto per usare il predefinito'),
              ),
              const SizedBox(height: 16),
              // Text input
              Row(
                children: [
                  Expanded(child: Text('Testo', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500))),
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: _pasteClipboard,
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.content_paste_outlined, size: 14), SizedBox(width: 4), Text('Incolla')]),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ShadInput(
                controller: _textCtrl,
                placeholder: const Text('Testo da analizzare...'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              // File attachments
              Row(
                children: [
                  Expanded(child: Text('File (${_attachments.length})', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500))),
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: _pickFiles,
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.attach_file_outlined, size: 14), SizedBox(width: 4), Text('Aggiungi')]),
                  ),
                ],
              ),
              for (var i = 0; i < _attachments.length; i++)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: ShadCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(_attachments[i].mimeType.startsWith('image') ? Icons.image_outlined : Icons.picture_as_pdf_outlined, size: 16, color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text(_attachments[i].name, style: shadTheme.textTheme.small)),
                        ShadButton.ghost(size: ShadButtonSize.icon, onPressed: () => setState(() => _attachments.removeAt(i)), child: const Icon(Icons.close, size: 14)),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (_testError != null) ...[
                _InlineError(message: _testError!, shadTheme: shadTheme),
                const SizedBox(height: 12),
              ],
              ShadButton(
                onPressed: (!_hasKey || _testing) ? null : _test,
                width: double.infinity,
                child: _testing
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.science_outlined, size: 16), SizedBox(width: 8), Text('Testa estrazione')]),
              ),
              if (!_hasKey && !_loadingConfig)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Configura prima la chiave API.', style: shadTheme.textTheme.muted.copyWith(fontSize: 12), textAlign: TextAlign.center),
                ),

              if (_result != null) ...[
                const SizedBox(height: 20),
                _SectionHeader(icon: Icons.check_circle_outline, label: 'Risultato', shadTheme: shadTheme),
                const SizedBox(height: 12),
                _ResultSummary(result: _result!, shadTheme: shadTheme),
                const SizedBox(height: 16),
                _SectionHeader(icon: Icons.code_outlined, label: 'JSON raw', shadTheme: shadTheme),
                const SizedBox(height: 8),
                ShadCard(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: shadTheme.colorScheme.muted.withValues(alpha: 0.5),
                  child: SelectableText(
                    _rawResult ?? '',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: shadTheme.colorScheme.foreground),
                  ),
                ),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.label, required this.shadTheme});
  final IconData icon;
  final String label;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: shadTheme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(label, style: shadTheme.textTheme.h4),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.hasKey, required this.keyPreview, required this.shadTheme});
  final bool hasKey;
  final String? keyPreview;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final color = hasKey ? const Color(0xFF10B981) : shadTheme.colorScheme.destructive;
    return ShadCard(
      padding: const EdgeInsets.all(14),
      backgroundColor: color.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(hasKey ? Icons.check_circle_outline : Icons.error_outline, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasKey ? 'API key configurata' : 'Nessuna API key',
                  style: shadTheme.textTheme.small.copyWith(color: color, fontWeight: FontWeight.w600),
                ),
                if (hasKey && keyPreview != null)
                  Text(keyPreview!, style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message, required this.shadTheme});
  final String message;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(12),
      backgroundColor: shadTheme.colorScheme.destructive.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(Icons.error_outline, size: 16, color: shadTheme.colorScheme.destructive),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 13))),
        ],
      ),
    );
  }
}

class _InlineSuccess extends StatelessWidget {
  const _InlineSuccess({required this.message, required this.shadTheme});
  final String message;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF10B981);
    return ShadCard(
      padding: const EdgeInsets.all(12),
      backgroundColor: green.withValues(alpha: 0.08),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: green),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(color: green, fontSize: 13))),
        ],
      ),
    );
  }
}

class _ResultSummary extends StatelessWidget {
  const _ResultSummary({required this.result, required this.shadTheme});
  final AiExtractionResult result;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final c = result.confidenza >= 0.75
        ? const Color(0xFF10B981)
        : result.confidenza >= 0.4
            ? const Color(0xFFF59E0B)
            : const Color(0xFFEF4444);
    return ShadCard(
      padding: const EdgeInsets.all(14),
      backgroundColor: shadTheme.colorScheme.primary.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(child: Text(result.titolo, style: shadTheme.textTheme.p.copyWith(fontWeight: FontWeight.w700))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
              child: Text('${(result.confidenza * 100).round()}%', style: TextStyle(fontSize: 11, color: c, fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 6),
          Text('tipo: ${result.tipo}${result.tipoAppuntamento != null ? ' / ${result.tipoAppuntamento}' : ''}',
              style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground)),
          if (result.importo != null)
            Text('importo: €${result.importo!.toStringAsFixed(2)}', style: shadTheme.textTheme.small),
          if (result.quando != null)
            Text('quando: ${result.quando!.toLocal()}', style: shadTheme.textTheme.small),
          const SizedBox(height: 6),
          Text(result.motivazione, style: shadTheme.textTheme.muted.copyWith(fontSize: 11, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class _Attachment {
  const _Attachment({required this.name, required this.base64, required this.mimeType});
  final String name;
  final String base64;
  final String mimeType;
}
