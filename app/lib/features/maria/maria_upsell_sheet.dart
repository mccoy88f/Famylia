import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/session/family_context.dart';

/// Bottom sheet upsell MarIA — mostrato quando l'utente tenta di usare
/// una funzione AI senza abbonamento Premium.
class MarIAUpsellSheet extends StatelessWidget {
  const MarIAUpsellSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const MarIAUpsellSheet(),
      );

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final shadTheme = ShadTheme.of(context);
    final family = context.read<FamilyContext>();

    return Container(
      decoration: BoxDecoration(
        color: shadTheme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: shadTheme.colorScheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // MarIA avatar
            Container(
              width: 72, height: 72,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [shadTheme.colorScheme.primary, shadTheme.colorScheme.primary.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('M', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            Text(s.mariaUpsellTitle, style: shadTheme.textTheme.h3, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(s.mariaUpsellBody, style: shadTheme.textTheme.muted, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            // Features
            for (final feat in [s.mariaFeature1, s.mariaFeature2, s.mariaFeature3, s.mariaFeature4])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 4),
                    Expanded(child: Text(feat, style: const TextStyle(fontSize: 15))),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            ShadButton(
              width: double.infinity,
              onPressed: () async {
                await family.activateMarIA();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${s.mariaName} è ora attiva nella tua famiglia! 🎉'),
                      backgroundColor: shadTheme.colorScheme.primary,
                    ),
                  );
                }
              },
              child: Text(s.mariaUpsellButton),
            ),
            const SizedBox(height: 8),
            ShadButton.ghost(
              width: double.infinity,
              onPressed: () => Navigator.pop(context),
              child: const Text('Non ora'),
            ),
          ],
        ),
      ),
    );
  }
}
