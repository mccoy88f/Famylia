import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuotaExceededDialog extends StatelessWidget {
  const QuotaExceededDialog({
    required this.resetDate,
    required this.isTokenLimit,
    super.key,
  });

  final DateTime resetDate;
  final bool isTokenLimit;

  static Future<void> show(
    BuildContext context, {
    required DateTime resetDate,
    required bool isTokenLimit,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => QuotaExceededDialog(
        resetDate: resetDate,
        isTokenLimit: isTokenLimit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('d MMMM yyyy', 'it').format(resetDate);
    final limitType = isTokenLimit ? 'token mensili' : 'costo mensile';
    return AlertDialog(
      title: const Text('Limite AI raggiunto'),
      content: Text(
        'Hai raggiunto il limite di $limitType per questa famiglia.\n\n'
        'Il contatore si azzera il $formatted.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
