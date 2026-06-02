import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'activity_duplicate_checker.dart';

/// Chiede se procedere con il salvataggio nonostante il duplicato.
/// Restituisce `true` per salvare comunque, `false` per annullare.
Future<bool> showDuplicateActivityDialog(
  BuildContext context,
  ActivityDuplicateMatch match,
) async {
  final shadTheme = ShadTheme.of(context);
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: shadTheme.colorScheme.background,
      title: Text('Elemento già presente', style: shadTheme.textTheme.h4),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Esiste già un ${match.activityLabel.toLowerCase()} molto simile:',
              style: shadTheme.textTheme.muted,
            ),
            const SizedBox(height: 12),
            ShadCard(
              padding: const EdgeInsets.all(14),
              backgroundColor: shadTheme.colorScheme.muted.withValues(alpha: 0.35),
              border: Border.all(color: shadTheme.colorScheme.border),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.content_copy_outlined,
                        size: 18,
                        color: shadTheme.colorScheme.destructive,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          match.existingTitle,
                          style: shadTheme.textTheme.p.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  for (final row in match.details) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${row.key}: ${row.value}',
                      style: shadTheme.textTheme.muted.copyWith(fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Vuoi salvare comunque o annullare?',
              style: shadTheme.textTheme.small,
            ),
          ],
        ),
      ),
      actions: [
        ShadButton.ghost(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Annulla'),
        ),
        ShadButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Salva comunque'),
        ),
      ],
    ),
  );
  return result == true;
}
