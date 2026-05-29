import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class OnboardingHubScreen extends StatefulWidget {
  const OnboardingHubScreen({super.key});

  @override
  State<OnboardingHubScreen> createState() => _OnboardingHubScreenState();
}

class _OnboardingHubScreenState extends State<OnboardingHubScreen> {
  final _families = FamilyRepository();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadExistingFamilies();
  }

  Future<void> _loadExistingFamilies() async {
    try {
      final list = await _families.listMyFamilies();
      if (!mounted) return;
      if (list.isNotEmpty) {
        final first = list.first;
        await context.read<FamilyContext>().setActiveFamily(
              id: first.family.id!,
              name: first.family.name,
            );
        if (mounted) context.go(AppRoutes.home);
        return;
      }
    } catch (_) {
      // Server non raggiungibile: mostra hub manuale
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.family_restroom, size: 72, color: theme.colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'La tua famiglia su Famylia',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Crea un nuovo gruppo oppure unisciti con un codice invito.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () => context.push(AppRoutes.createFamily),
                icon: const Icon(Icons.add_home_work_outlined),
                label: const Text('Crea una famiglia'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.joinFamily),
                icon: const Icon(Icons.qr_code_2_outlined),
                label: const Text('Ho un codice invito'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
