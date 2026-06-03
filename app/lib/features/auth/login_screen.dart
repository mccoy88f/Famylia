import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/famylia_services.dart';
import '../../core/config/app_config.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/router/app_router.dart';

/// Mostra il pulsante "Accedi su dominio privato" solo quando:
/// - Non siamo su web (su web l'URL si auto-rileva)
/// - La build include --dart-define=SHOW_PRIVATE_SERVER=true
///   OPPURE non è una release (debug/profile = utile in sviluppo)
const _showPrivateServerButton =
    bool.fromEnvironment('SHOW_PRIVATE_SERVER', defaultValue: !kReleaseMode);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _auth = AuthRepository();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = AppLocalizations.of(context);
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _error = s.loginEmailError);
      return;
    }
    if (pass.length < 8) {
      setState(() => _error = s.loginPasswordError);
      return;
    }
    setState(() { _loading = true; _error = null; });
    try {
      await _auth.signInWithEmail(email: email, password: pass);
      if (!mounted) return;
      context.go(AppRoutes.onboarding);
    } on AuthException catch (e) {
      setState(() => _error = e.message);
    } catch (_) {
      setState(() => _error = AppLocalizations.of(context).loginConnectionError);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _showPrivateServerDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final ctrl = TextEditingController(text: AppConfig.customUrl ?? '');
    if (!mounted) return;
    final shadTheme = ShadTheme.of(context);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: shadTheme.colorScheme.background,
        title: const Text('Server privato'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inserisci l\'indirizzo del tuo server Famylia.\nEs: 192.168.1.10:8080 oppure https://mio.server.com',
              style: TextStyle(fontSize: 13, color: shadTheme.colorScheme.mutedForeground),
            ),
            const SizedBox(height: 12),
            ShadInput(
              controller: ctrl,
              placeholder: const Text('https://... oppure IP:porta'),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Annulla'),
          ),
          if (AppConfig.customUrl != null)
            TextButton(
              onPressed: () async {
                await AppConfig.setCustomUrl(prefs, null);
                await FamyliaServices.reinit();
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) setState(() {});
              },
              child: const Text('Usa default', style: TextStyle(color: Colors.grey)),
            ),
          TextButton(
            onPressed: () async {
              await AppConfig.setCustomUrl(prefs, ctrl.text.trim().isEmpty ? null : ctrl.text.trim());
              await FamyliaServices.reinit();
              if (ctx.mounted) Navigator.pop(ctx);
              if (mounted) setState(() {});
            },
            child: const Text('Salva'),
          ),
        ],
      ),
    );
    ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final s = AppLocalizations.of(context);
    final isCustomServer = !kIsWeb && AppConfig.customUrl != null;

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.home_work_rounded, size: 56, color: shadTheme.colorScheme.primary),
                  const SizedBox(height: 16),
                  Text('Famylia', textAlign: TextAlign.center, style: shadTheme.textTheme.h1),
                  const SizedBox(height: 8),
                  Text(
                    s.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: shadTheme.textTheme.muted,
                  ),
                  if (isCustomServer) ...[
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: shadTheme.colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '🔒 ${AppConfig.customUrl}',
                          style: TextStyle(fontSize: 11, color: shadTheme.colorScheme.primary),
                        ),
                      ),
                    ),
                  ],
                  if (_error != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 14),
                    ),
                  ],
                  const SizedBox(height: 24),
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
                    placeholder: const Text('Password'),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(Icons.lock_outline, size: 18, color: shadTheme.colorScheme.mutedForeground),
                    ),
                    onSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 24),
                  ShadButton(
                    onPressed: _loading ? null : _submit,
                    width: double.infinity,
                    child: _loading
                        ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(s.loginButton),
                  ),
                  const SizedBox(height: 12),
                  ShadButton.ghost(
                    onPressed: () => context.push(AppRoutes.register),
                    width: double.infinity,
                    child: Text(s.loginNoAccount),
                  ),
                  // Pulsante server privato — nascosto su store con SHOW_PRIVATE_SERVER=false
                  if (!kIsWeb && _showPrivateServerButton) ...[
                    const SizedBox(height: 24),
                    Center(
                      child: GestureDetector(
                        onTap: _showPrivateServerDialog,
                        child: Text(
                          isCustomServer ? '⚙️ Cambia server privato' : 'Accedi su dominio privato',
                          style: TextStyle(
                            fontSize: 12,
                            color: shadTheme.colorScheme.mutedForeground,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
