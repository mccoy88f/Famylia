import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/auth_repository.dart';
import '../../core/router/app_router.dart';

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
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text;
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _error = 'Inserisci un\'email valida');
      return;
    }
    if (pass.length < 8) {
      setState(() => _error = 'Password: minimo 8 caratteri');
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
      setState(() => _error = 'Errore di connessione. Il server è avviato?');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
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
                    'Accedi per gestire la tua famiglia',
                    textAlign: TextAlign.center,
                    style: shadTheme.textTheme.muted,
                  ),
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
                        : const Text('Accedi'),
                  ),
                  const SizedBox(height: 12),
                  ShadButton.ghost(
                    onPressed: () => context.push(AppRoutes.register),
                    width: double.infinity,
                    child: const Text('Non hai un account? Registrati'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
