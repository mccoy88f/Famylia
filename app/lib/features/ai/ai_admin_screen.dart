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
  final _textCtrl = TextEditingController();
  final _modelCtrl = TextEditingController(text: 'google/gemini-2.5-flash-preview');

  bool _checkingConfig = true;
  bool _isConfigured = false;
  bool _loading = false;
  String? _error;
  String? _rawResult;
  AiExtractionResult? _result;

  final List<_Attachment> _attachments = [];

  @override
  void initState() {
    super.initState();
    _checkConfig();
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    _modelCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkConfig() async {
    try {
      final ok = await _repo.isConfigured();
      if (mounted) setState(() { _isConfigured = ok; _checkingConfig = false; });
    } catch (_) {
      if (mounted) setState(() { _isConfigured = false; _checkingConfig = false; });
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
        final mime = _mimeFromExt(f.extension ?? '');
        _attachments.add(_Attachment(name: f.name, base64: base64Encode(f.bytes!), mimeType: mime));
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
      setState(() => _error = 'Inserisci testo o file.');
      return;
    }
    setState(() { _loading = true; _error = null; _result = null; _rawResult = null; });
    try {
      final result = await _repo.extractActivity(
        familyId,
        text: text.isEmpty ? null : text,
        base64Images: _attachments.isEmpty ? null : _attachments.map((a) => a.base64).toList(),
        mimeTypes: _attachments.isEmpty ? null : _attachments.map((a) => a.mimeType).toList(),
        model: _modelCtrl.text.trim().isEmpty ? null : _modelCtrl.text.trim(),
      );
      if (mounted) {
        setState(() {
          _result = result;
          _rawResult = const JsonEncoder.withIndent('  ').convert(result.raw);
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = _repo.errorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
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
              // Config status
              _ConfigStatus(isConfigured: _isConfigured, checking: _checkingConfig, shadTheme: shadTheme),
              const SizedBox(height: 20),

              // Model
              Text('Modello OpenRouter', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
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
              Text('Esempi: google/gemini-2.5-flash-preview · anthropic/claude-3.5-haiku · meta-llama/llama-3.2-11b-vision-instruct:free',
                  style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
              const SizedBox(height: 20),

              // Input testo
              Row(
                children: [
                  Expanded(child: Text('Testo di test', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500))),
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
                placeholder: const Text('Incolla testo da analizzare...'),
                maxLines: 5,
              ),
              const SizedBox(height: 16),

              // Allegati
              Row(
                children: [
                  Expanded(child: Text('File allegati (${_attachments.length})', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500))),
                  ShadButton.ghost(
                    size: ShadButtonSize.sm,
                    onPressed: _pickFiles,
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.attach_file_outlined, size: 14), SizedBox(width: 4), Text('Aggiungi')]),
                  ),
                ],
              ),
              if (_attachments.isNotEmpty) ...[
                const SizedBox(height: 8),
                for (var i = 0; i < _attachments.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: ShadCard(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Icon(_attachments[i].mimeType.startsWith('image') ? Icons.image_outlined : Icons.picture_as_pdf_outlined, size: 16, color: shadTheme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Expanded(child: Text(_attachments[i].name, style: shadTheme.textTheme.small)),
                          ShadButton.ghost(size: ShadButtonSize.icon, onPressed: () => setState(() => _attachments.removeAt(i)), child: Icon(Icons.close, size: 14)),
                        ],
                      ),
                    ),
                  ),
              ],
              const SizedBox(height: 20),

              ShadButton(
                onPressed: (_isConfigured && !_loading) ? _test : null,
                width: double.infinity,
                child: _loading
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.science_outlined, size: 16), SizedBox(width: 8), Text('Testa estrazione')]),
              ),

              if (_error != null) ...[
                const SizedBox(height: 16),
                ShadCard(
                  backgroundColor: shadTheme.colorScheme.destructive.withValues(alpha: 0.1),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, size: 16, color: shadTheme.colorScheme.destructive),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_error!, style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 13))),
                    ],
                  ),
                ),
              ],

              if (_result != null) ...[
                const SizedBox(height: 20),
                Text('Risultato', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                _ResultSummary(result: _result!, shadTheme: shadTheme),
                const SizedBox(height: 16),
                Text('JSON raw', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
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
              _ConfigInstructions(shadTheme: shadTheme),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConfigStatus extends StatelessWidget {
  const _ConfigStatus({required this.isConfigured, required this.checking, required this.shadTheme});
  final bool isConfigured;
  final bool checking;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    if (checking) {
      return ShadCard(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: 12),
          Text('Verifica configurazione...', style: shadTheme.textTheme.small),
        ]),
      );
    }
    final color = isConfigured ? const Color(0xFF10B981) : shadTheme.colorScheme.destructive;
    final icon = isConfigured ? Icons.check_circle_outline : Icons.error_outline;
    final msg = isConfigured ? 'OpenRouter API key configurata' : 'OpenRouter API key non trovata';

    return ShadCard(
      padding: const EdgeInsets.all(14),
      backgroundColor: color.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 10),
          Expanded(child: Text(msg, style: shadTheme.textTheme.small.copyWith(color: color, fontWeight: FontWeight.w500))),
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
          Row(
            children: [
              Expanded(child: Text(result.titolo, style: shadTheme.textTheme.p.copyWith(fontWeight: FontWeight.w700))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                child: Text('${(result.confidenza * 100).round()}%', style: TextStyle(fontSize: 11, color: c, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('Tipo: ${result.tipo}${result.tipoAppuntamento != null ? ' (${result.tipoAppuntamento})' : ''}',
              style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground)),
          if (result.importo != null)
            Text('Importo: €${result.importo!.toStringAsFixed(2)}', style: shadTheme.textTheme.small),
          if (result.quando != null)
            Text('Data: ${result.quando!.toLocal()}', style: shadTheme.textTheme.small),
          const SizedBox(height: 6),
          Text(result.motivazione, style: shadTheme.textTheme.muted.copyWith(fontSize: 11, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class _ConfigInstructions extends StatelessWidget {
  const _ConfigInstructions({required this.shadTheme});
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.settings_outlined, size: 16, color: shadTheme.colorScheme.mutedForeground),
            const SizedBox(width: 6),
            Text('Come configurare', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 12),
          Text(
            'Aggiungi la tua chiave OpenRouter in server/config/passwords.yaml:\n\n'
            'development:\n'
            '  openRouterApiKey: \'sk-or-v1-...\'\n\n'
            'Ottieni la chiave su openrouter.ai — i modelli gratuiti (suffisso :free) non richiedono credito.',
            style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground, fontFamily: 'monospace'),
          ),
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
