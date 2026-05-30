import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class CreateFamilyScreen extends StatefulWidget {
  const CreateFamilyScreen({super.key});

  @override
  State<CreateFamilyScreen> createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _families = FamilyRepository();
  bool _loading = false;
  String? _inviteCode;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final family = await _families.createFamily(_nameController.text);
      if (!mounted) return;
      await context.read<FamilyContext>().setActiveFamily(
            id: family.id!,
            name: family.name,
            accentColor: family.accentColor,
            role: FamilyRole.admin,
          );
      setState(() => _inviteCode = family.inviteCode);
    } catch (e) {
      setState(() => _error = _families.userFacingError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _goHome() => context.go(AppRoutes.home);

  @override
  Widget build(BuildContext context) {
    if (_inviteCode != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Famiglia creata')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                'Condividi questo codice con i membri:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              SelectableText(
                _inviteCode!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _inviteCode!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Codice copiato')),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copia codice'),
              ),
              const Spacer(),
              FilledButton(onPressed: _goHome, child: const Text('Vai alla home')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Crea famiglia')),
      body: SafeArea(
        child: Padding(
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
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome famiglia',
                    hintText: 'es. Famiglia Rossi',
                    prefixIcon: Icon(Icons.home_outlined),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Inserisci un nome' : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _loading ? null : _submit,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Crea'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
