import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../api/expense_repository.dart';
import '../extensions/context_extensions.dart';
import '../session/app_state.dart';
import 'package:provider/provider.dart';

// Encodes a preventivato cost into a description string.
String encodePreventivato(String description, double cost) {
  final base = description.replaceAll(RegExp(r'\s*\[preventivato:[^\]]+\]'), '').trim();
  final tag = '[preventivato:${cost.toStringAsFixed(2)}]';
  return base.isEmpty ? tag : '$base\n$tag';
}

// Extracts preventivato from description, returns null if not present.
double? parsePreventivato(String? description) {
  if (description == null) return null;
  final match = RegExp(r'\[preventivato:([\d.]+)\]').firstMatch(description);
  if (match == null) return null;
  return double.tryParse(match.group(1)!);
}

// Returns the description without the preventivato tag.
String cleanDescription(String? description) {
  if (description == null) return '';
  return description.replaceAll(RegExp(r'\s*\[preventivato:[^\]]+\]'), '').trim();
}

// Shows the "registra spesa" dialog on activity completion.
// Returns true if completion should proceed (always), and creates an expense
// if the user entered a cost.
Future<bool> showRegistraSpesaDialog(
  BuildContext context, {
  required String titolo,
  required int familyId,
  double? costoPreventivato,
}) async {
  final shadTheme = ShadTheme.of(context);
  final ctrl = TextEditingController(
    text: costoPreventivato != null ? costoPreventivato.toStringAsFixed(2) : '',
  );
  final me = context.read<AppState>().signedInUser?.id ?? 0;

  final result = await showDialog<_DialogResult>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: shadTheme.colorScheme.background,
      title: Row(
        children: [
          Icon(Icons.check_circle_outline, color: shadTheme.colorScheme.primary, size: 20),
          const SizedBox(width: 8),
          const Text('Attività completata'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titolo, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          if (costoPreventivato != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Costo preventivato: €${costoPreventivato.toStringAsFixed(2)}',
                style: TextStyle(color: shadTheme.colorScheme.mutedForeground, fontSize: 13),
              ),
            ),
          TextField(
            controller: ctrl,
            autofocus: costoPreventivato != null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Costo effettivo (opzionale)',
              prefixText: '€ ',
              hintText: '0.00',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
      actions: [
        ShadButton.ghost(
          onPressed: () => Navigator.pop(ctx, _DialogResult.skip),
          child: const Text('Salta'),
        ),
        ShadButton(
          onPressed: () => Navigator.pop(ctx, _DialogResult.registra),
          child: const Text('Registra spesa'),
        ),
      ],
    ),
  );

  if (result == _DialogResult.registra) {
    final importo = double.tryParse(ctrl.text.replaceAll(',', '.'));
    if (importo != null && importo > 0 && context.mounted) {
      try {
        await ExpenseRepository().create(familyId, titolo, importo, me);
      } catch (_) {}
    }
  }

  return true;
}

enum _DialogResult { skip, registra }
