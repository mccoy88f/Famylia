import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

import '../../core/api/calendar_repository.dart';
import '../../core/extensions/context_extensions.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _repo = CalendarRepository();
  List<CalendarEvent> _events = [];
  bool _loading = true;
  final _fmt = DateFormat('EEE d MMM · HH:mm');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, now.day);
    final to = from.add(const Duration(days: 30));
    try {
      final events = await _repo.list(familyId, from, to);
      if (mounted) setState(() => _events = events);
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

  Future<void> _add() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final titleCtrl = TextEditingController();
    var start = DateTime.now().add(const Duration(hours: 2));

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo evento'),
        content: TextField(
          controller: titleCtrl,
          decoration: const InputDecoration(labelText: 'Titolo'),
        ),
        actions: [
          ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
        ],
      ),
    );
    if (ok != true || titleCtrl.text.trim().isEmpty) return;
    try {
      await _repo.create(familyId, titleCtrl.text, start);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _events.isEmpty
                  ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('Nessun evento nei prossimi 30 giorni')),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _events.length,
                      itemBuilder: (_, i) {
                        final e = _events[i];
                        return ListTile(
                          leading: const Icon(Icons.event),
                          title: Text(e.title),
                          subtitle: Text(_fmt.format(e.startAt.toLocal())),
                        );
                      },
                    ),
            ),
    );
  }
}
