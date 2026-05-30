import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    } catch (_) {}
    finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);

    if (_loading) {
      return Scaffold(
        backgroundColor: shadTheme.colorScheme.background,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(Icons.family_restroom, size: 72, color: shadTheme.colorScheme.primary),
              const SizedBox(height: 24),
              Text(
                'La tua famiglia su Famylia',
                textAlign: TextAlign.center,
                style: shadTheme.textTheme.h2,
              ),
              const SizedBox(height: 12),
              Text(
                'Crea un nuovo gruppo oppure unisciti con un codice invito.',
                textAlign: TextAlign.center,
                style: shadTheme.textTheme.muted,
              ),
              const Spacer(),
              ShadButton(
                onPressed: () => context.push(AppRoutes.createFamily),
                width: double.infinity,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_home_work_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Crea una famiglia'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ShadButton.outline(
                onPressed: () => context.push(AppRoutes.joinFamily),
                width: double.infinity,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.qr_code_2_outlined, size: 18),
                    SizedBox(width: 8),
                    Text('Ho un codice invito'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
