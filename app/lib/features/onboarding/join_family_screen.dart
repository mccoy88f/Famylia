import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({super.key});

  @override
  State<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _families = FamilyRepository();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final member = await _families.joinFamily(_codeController.text);
      final list = await _families.listMyFamilies();
      final match = list.where((f) => f.family.id == member.familyId).firstOrNull;
      final familyName = match?.family.name ?? 'Famiglia';
      if (!mounted) return;
      await context.read<FamilyContext>().setActiveFamily(
            id: member.familyId,
            name: familyName,
          );
      if (!mounted) return;
      context.go(AppRoutes.home);
    } catch (e) {
      setState(() => _error = _families.userFacingError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unisciti')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Inserisci il codice invito ricevuto da un admin della famiglia.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
                const SizedBox(height: 24),
                TextFormField(
                  controller: _codeController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Codice invito',
                    hintText: 'FAM-XXXXXX',
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().length < 6) {
                      return 'Codice non valido';
                    }
                    return null;
                  },
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
                      : const Text('Unisciti'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
