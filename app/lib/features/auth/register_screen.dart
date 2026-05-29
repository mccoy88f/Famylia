import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/auth_repository.dart';
import '../../core/router/app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  final _auth = AuthRepository();

  bool _loading = false;
  bool _awaitingCode = false;
  String? _error;
  String? _devCode;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _requestCode() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _auth.requestAccount(
        userName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      final devCode = await _auth.devVerificationCode(_emailController.text);
      if (!mounted) return;
      setState(() {
        _awaitingCode = true;
        _devCode = devCode;
        if (devCode != null) _codeController.text = devCode;
      });
      if (devCode != null) {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Codice di verifica (sviluppo)'),
            content: SelectableText(
              'Non inviamo email in locale.\n\nIl tuo codice è:\n\n$devCode',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Ho capito'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Nessuna email inviata in sviluppo. Controlla i log del server.',
            ),
            duration: Duration(seconds: 6),
          ),
        );
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
    if (_codeController.text.trim().length < 4) {
      setState(() => _error = 'Inserisci il codice di verifica');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _auth.completeAccount(
        email: _emailController.text,
        verificationCode: _codeController.text,
        password: _passwordController.text,
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
    return Scaffold(
      appBar: AppBar(title: const Text('Registrati')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      _error!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                if (!_awaitingCode) ...[
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (v) =>
                        v == null || v.trim().isEmpty ? 'Inserisci il nome' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (v) {
                      if (v == null || !v.contains('@')) return 'Email non valida';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (v) {
                      if (v == null || v.length < 8) return 'Minimo 8 caratteri';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _loading ? null : _requestCode,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Invia codice verifica'),
                  ),
                ] else ...[
                  Card(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _devCode != null
                            ? 'In locale non arriva alcuna email. Usa il codice mostrato sopra.'
                            : 'In locale non arriva alcuna email. Il codice è nei log del server '
                                '(riga "codice verifica per la tua email").',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  if (_devCode != null) ...[
                    const SizedBox(height: 12),
                    SelectableText(
                      'Codice: $_devCode',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Email: ${_emailController.text}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _codeController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      labelText: 'Codice verifica',
                      hintText: 'es. ABC123',
                      prefixIcon: Icon(Icons.pin_outlined),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _loading ? null : _completeRegistration,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Completa registrazione'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
