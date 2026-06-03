import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/admin_repository.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _repo = AdminRepository();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Inserisci email e password.');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _repo.login(email, password);
      if (mounted) {
        context.go('/admin/dashboard', extra: _repo);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = _repo.errorMessage(e);
        });
      }
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
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'MarIA Admin',
                    style: shadTheme.textTheme.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Accesso riservato agli amministratori',
                    style: shadTheme.textTheme.muted,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Email',
                    style: shadTheme.textTheme.small
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  ShadInput(
                    controller: _emailCtrl,
                    placeholder: const Text('admin@famylia.app'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Password',
                    style: shadTheme.textTheme.small
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  ShadInput(
                    controller: _passwordCtrl,
                    placeholder: const Text('Password'),
                    obscureText: true,
                    onSubmitted: (_) => _login(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    ShadCard(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: shadTheme.colorScheme.destructive
                          .withValues(alpha: 0.08),
                      child: Text(
                        _error!,
                        style: TextStyle(
                          color: shadTheme.colorScheme.destructive,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ShadButton(
                    onPressed: _loading ? null : _login,
                    width: double.infinity,
                    child: _loading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Accedi'),
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
