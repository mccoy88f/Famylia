import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_codeController.text.trim().length < 6) {
      setState(() => _error = 'Codice non valido');
      return;
    }
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

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Unisciti', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Inserisci il codice invito ricevuto da un admin della famiglia.',
                style: shadTheme.textTheme.muted,
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: TextStyle(color: shadTheme.colorScheme.destructive, fontSize: 14),
                ),
              ],
              const SizedBox(height: 24),
              ShadInput(
                controller: _codeController,
                textCapitalization: TextCapitalization.characters,
                placeholder: const Text('Codice invito (es. FAM-XXXXXX)'),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(Icons.vpn_key_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
                ),
                onSubmitted: (_) => _loading ? null : _submit(),
              ),
              const SizedBox(height: 24),
              ShadButton(
                onPressed: _loading ? null : _submit,
                width: double.infinity,
                child: _loading
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Unisciti'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
