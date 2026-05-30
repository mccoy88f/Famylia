import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/family_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class CreateFamilyScreen extends StatefulWidget {
  const CreateFamilyScreen({super.key});

  @override
  State<CreateFamilyScreen> createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
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
    if (_nameController.text.trim().isEmpty) {
      setState(() => _error = 'Inserisci un nome');
      return;
    }
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
    final shadTheme = ShadTheme.of(context);

    if (_inviteCode != null) {
      return Scaffold(
        backgroundColor: shadTheme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: shadTheme.colorScheme.background,
          surfaceTintColor: Colors.transparent,
          title: Text('Famiglia creata', style: shadTheme.textTheme.h4),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.check_circle_outline, size: 64, color: shadTheme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Condividi questo codice con i membri:',
                textAlign: TextAlign.center,
                style: shadTheme.textTheme.p,
              ),
              const SizedBox(height: 16),
              SelectableText(
                _inviteCode!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: shadTheme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              ShadButton.outline(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _inviteCode!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Codice copiato')),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.copy, size: 18),
                    SizedBox(width: 8),
                    Text('Copia codice'),
                  ],
                ),
              ),
              const Spacer(),
              ShadButton(
                onPressed: _goHome,
                width: double.infinity,
                child: const Text('Vai alla home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('Crea famiglia', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: Padding(
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
              ShadInput(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                placeholder: const Text('Nome famiglia (es. Famiglia Rossi)'),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(Icons.home_outlined, size: 18, color: shadTheme.colorScheme.mutedForeground),
                ),
                onSubmitted: (_) => _loading ? null : _submit(),
              ),
              const SizedBox(height: 24),
              ShadButton(
                onPressed: _loading ? null : _submit,
                width: double.infinity,
                child: _loading
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Crea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
