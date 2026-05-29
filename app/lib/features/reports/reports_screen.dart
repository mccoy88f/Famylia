import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/api/report_repository.dart';
import '../../core/extensions/context_extensions.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _repo = ReportRepository();
  FamilyReport? _report;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      final report = await _repo.getReport(familyId);
      if (mounted) setState(() => _report = report);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = _report;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        actions: [
          if (r != null)
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copia CSV',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: r.csvExport));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('CSV copiato')),
                  );
                }
              },
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _MetricTile('Task aperti', '${r?.openTodos ?? 0}'),
                  _MetricTile('Task completati', '${r?.completedTodos ?? 0}'),
                  _MetricTile('Spese totali', '€${r?.totalExpenses.toStringAsFixed(2) ?? '0'}'),
                  _MetricTile('Scadenze (30 gg)', '${r?.upcomingDeadlines ?? 0}'),
                  _MetricTile('Liste spesa attive', '${r?.activeShoppingLists ?? 0}'),
                ],
              ),
            ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        trailing: Text(value, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
