import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/auth_repository.dart';
import '../../core/router/app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _auth = AuthRepository();

  bool _loading = false;
  bool _awaitingCode = false;
  String? _error;
  String? _devCode;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _requestCode() async {
    if (_nameCtrl.text.trim().isEmpty) {
      setState(() => _error = 'Inserisci il nome');
      return;
    }
    if (!_emailCtrl.text.contains('@')) {
      setState(() => _error = 'Email non valida');
      return;
    }
    if (_passCtrl.text.length < 8) {
      setState(() => _error = 'Password: minimo 8 caratteri');
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await _auth.requestAccount(
        userName: _nameCtrl.text,
        email: _emailCtrl.text,
        password: _passCtrl.text,
      );
      final devCode = await _auth.devVerificationCode(_emailCtrl.text);
      if (!mounted) return;
      setState(() {
        _awaitingCode = true;
        _devCode = devCode;
        if (devCode != null) _codeCtrl.text = devCode;
      });
      if (devCode != null) {
        final shadTheme = ShadTheme.of(context);
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: shadTheme.colorScheme.background,
            title: Text('Codice di verifica (sviluppo)', style: shadTheme.textTheme.h4),
            content: SelectableText(
              'Non inviamo email in locale.\n\nIl tuo codice è:\n\n$devCode',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            actions: [
              FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Ho capito')),
            ],
          ),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nessuna email inviata in sviluppo. Controlla i log del server.'),
              duration: Duration(seconds: 6),
            ),
          );
        }
      }
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Errore di connessione al server.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _completeRegistration() async {
    if (_codeCtrl.text.trim().length < 4) {
      setState(() => _error = 'Inserisci il codice di verifica');
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await _auth.completeAccount(
        email: _emailCtrl.text,
        verificationCode: _codeCtrl.text,
        password: _passCtrl.text,
      );
      if (!mounted) return;
      context.go(AppRoutes.onboarding);
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = 'Verifica fallita. Controlla il codice.');
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
        title: Text('Registrati', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _error!,
                    style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 14),
                  ),
                ),
              if (!_awaitingCode) ...[
                ShadInput(
                  controller: _nameCtrl,
                  textCapitalization: TextCapitalization.words,
                  placeholder: const Text('Nome'),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(Icons.person_outline, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ),
                const SizedBox(height: 12),
                ShadInput(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  placeholder: const Text('Email'),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(Icons.email_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ),
                const SizedBox(height: 12),
                ShadInput(
                  controller: _passCtrl,
                  obscureText: true,
                  placeholder: const Text('Password (min. 8 caratteri)'),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(Icons.lock_outline, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ),
                const SizedBox(height: 24),
                ShadButton(
                  onPressed: _loading ? null : _requestCode,
                  width: double.infinity,
                  child: _loading
                      ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Invia codice verifica'),
                ),
              ] else ...[
                ShadCard(
                  backgroundColor: shadTheme.colorScheme.muted.withValues(alpha: 0.5),
                  child: Text(
                    _devCode != null
                        ? 'In locale non arriva alcuna email. Usa il codice mostrato sopra.'
                        : 'In locale non arriva alcuna email. Il codice è nei log del server.',
                    style: shadTheme.textTheme.muted,
                  ),
                ),
                if (_devCode != null) ...[
                  const SizedBox(height: 12),
                  SelectableText(
                    'Codice: $_devCode',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 16),
                Text('Email: ${_emailCtrl.text}', style: shadTheme.textTheme.muted),
                const SizedBox(height: 16),
                ShadInput(
                  controller: _codeCtrl,
                  textCapitalization: TextCapitalization.characters,
                  placeholder: const Text('Codice verifica (es. ABC123)'),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(Icons.pin_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  ),
                ),
                const SizedBox(height: 24),
                ShadButton(
                  onPressed: _loading ? null : _completeRegistration,
                  width: double.infinity,
                  child: _loading
                      ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Text('Completa registrazione'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
