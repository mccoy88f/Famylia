import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/family_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({super.key});

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
  final _codeController = TextEditingController();
  final _families = FamilyRepository();
  bool _loading = false;
  String? _error;
  bool _showScanner = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _codeController.text.trim();
    if (code.length < 4) {
      setState(() => _error = 'Codice non valido');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final member = await _families.joinFamily(code);
      final list = await _families.listMyFamilies();
      final match = list.where((f) => f.family.id == member.familyId).firstOrNull;
      final familyName = match?.family.name ?? 'Famiglia';
      if (!mounted) return;
      await context.read<FamilyContext>().setActiveFamily(
            id: member.familyId,
            name: familyName,
            accentColor: match?.family.accentColor,
            role: match?.role,
          );
      if (!mounted) return;
      context.go(AppRoutes.home);
    } catch (e) {
      setState(() => _error = _families.userFacingError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _onQrDetect(BarcodeCapture capture) {
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null || raw.isEmpty) return;
    // Extract code from URL format "famylia://join/<CODE>" or raw code
    String code = raw;
    if (raw.contains('/join/')) {
      code = raw.split('/join/').last.trim();
    }
    _codeController.text = code.toUpperCase();
    setState(() => _showScanner = false);
    // Auto-submit after QR scan
    Future.microtask(_submit);
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Unisciti alla famiglia', style: shadTheme.textTheme.h4),
        actions: [
          if (!_showScanner)
            IconButton(
              icon: Icon(Icons.qr_code_scanner, color: shadTheme.colorScheme.foreground),
              tooltip: 'Scansiona QR',
              onPressed: () => setState(() { _showScanner = true; _error = null; }),
            ),
          if (_showScanner)
            IconButton(
              icon: Icon(Icons.keyboard_alt_outlined, color: shadTheme.colorScheme.foreground),
              tooltip: 'Inserisci codice',
              onPressed: () => setState(() => _showScanner = false),
            ),
        ],
      ),
      body: SafeArea(
        child: _showScanner ? _QrScannerView(onDetect: _onQrDetect) : _CodeEntryView(
          codeController: _codeController,
          error: _error,
          loading: _loading,
          onSubmit: _submit,
          onShowScanner: () => setState(() { _showScanner = true; _error = null; }),
          shadTheme: shadTheme,
        ),
      ),
    );
  }
}

class _CodeEntryView extends StatelessWidget {
  const _CodeEntryView({
    required this.codeController,
    required this.error,
    required this.loading,
    required this.onSubmit,
    required this.onShowScanner,
    required this.shadTheme,
  });

  final TextEditingController codeController;
  final String? error;
  final bool loading;
  final VoidCallback onSubmit;
  final VoidCallback onShowScanner;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          // QR scan button prominent at top
          ShadButton.outline(
            onPressed: onShowScanner,
            width: double.infinity,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.qr_code_scanner, size: 20),
                SizedBox(width: 8),
                Text('Scansiona il QR code'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(color: shadTheme.colorScheme.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('oppure', style: shadTheme.textTheme.muted),
              ),
              Expanded(child: Divider(color: shadTheme.colorScheme.border)),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Inserisci il codice invito ricevuto da un admin della famiglia.',
            style: shadTheme.textTheme.muted,
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(
              error!,
              style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 14),
            ),
          ],
          const SizedBox(height: 16),
          ShadInput(
            controller: codeController,
            textCapitalization: TextCapitalization.characters,
            placeholder: const Text('Codice invito (es. FAM-XXXXXX)'),
            leading: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Icon(Icons.vpn_key_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
            ),
            onSubmitted: (_) => loading ? null : onSubmit(),
          ),
          const SizedBox(height: 24),
          ShadButton(
            onPressed: loading ? null : onSubmit,
            width: double.infinity,
            child: loading
                ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Unisciti'),
          ),
        ],
      ),
    );
  }
}

class _QrScannerView extends StatelessWidget {
  const _QrScannerView({required this.onDetect});
  final void Function(BarcodeCapture) onDetect;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              MobileScanner(onDetect: onDetect),
              // Overlay with scan frame
              Center(
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    border: Border.all(color: shadTheme.colorScheme.primary, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Inquadra il QR code mostrato da un membro della famiglia',
            textAlign: TextAlign.center,
            style: shadTheme.textTheme.muted,
          ),
        ),
      ],
    );
  }
}
