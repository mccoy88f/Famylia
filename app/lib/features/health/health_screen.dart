import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/api/health_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/health/health_labels.dart';
import '../../core/router/app_router.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen>
    with SingleTickerProviderStateMixin {
  final _repo = HealthRepository();
  late final TabController _tabs;
  final _dateFmt = DateFormat('EEE d MMM · HH:mm');
  final _dateOnlyFmt = DateFormat('d MMM yyyy');

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  HealthEntryType _typeForTab(int index) => switch (index) {
        0 => HealthEntryType.medicalVisit,
        1 => HealthEntryType.diet,
        _ => HealthEntryType.sportActivity,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salute'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Visite', icon: Icon(Icons.medical_services_outlined)),
            Tab(text: 'Diete', icon: Icon(Icons.restaurant_menu_outlined)),
            Tab(text: 'Sport', icon: Icon(Icons.fitness_center_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: List.generate(
          3,
          (i) => _HealthTab(
            type: _typeForTab(i),
            repo: _repo,
            dateFmt: _dateFmt,
            dateOnlyFmt: _dateOnlyFmt,
          ),
        ),
      ),
    );
  }
}

class _HealthTab extends StatefulWidget {
  const _HealthTab({
    required this.type,
    required this.repo,
    required this.dateFmt,
    required this.dateOnlyFmt,
  });

  final HealthEntryType type;
  final HealthRepository repo;
  final DateFormat dateFmt;
  final DateFormat dateOnlyFmt;

  @override
  State<_HealthTab> createState() => _HealthTabState();
}

class _HealthTabState extends State<_HealthTab> {
  List<HealthEntry> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      final items = await widget.repo.list(familyId, type: widget.type);
      if (mounted) setState(() => _items = items);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.repo.errorMessage(e))),
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
    final descCtrl = TextEditingController();
    final providerCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    final dietGoalCtrl = TextEditingController();
    final caloriesCtrl = TextEditingController();
    final sportTypeCtrl = TextEditingController();
    final durationCtrl = TextEditingController();
    var scheduled = DateTime.now().add(const Duration(days: 7));
    SportIntensity intensity = SportIntensity.medium;

    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          title: Text('Nuova ${HealthLabels.type(widget.type).toLowerCase()}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Titolo *'),
                ),
                if (widget.type == HealthEntryType.medicalVisit) ...[
                  TextField(
                    controller: providerCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Medico / struttura',
                    ),
                  ),
                  TextField(
                    controller: locationCtrl,
                    decoration: const InputDecoration(labelText: 'Luogo'),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Data: ${widget.dateOnlyFmt.format(scheduled)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: scheduled,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365 * 3)),
                      );
                      if (picked != null) {
                        setDialog(() => scheduled = picked);
                      }
                    },
                  ),
                ],
                if (widget.type == HealthEntryType.diet) ...[
                  TextField(
                    controller: dietGoalCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Obiettivo (es. mediterranea)',
                    ),
                  ),
                  TextField(
                    controller: caloriesCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Calorie giornaliere target',
                    ),
                  ),
                  TextField(
                    controller: descCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(labelText: 'Note'),
                  ),
                ],
                if (widget.type == HealthEntryType.sportActivity) ...[
                  TextField(
                    controller: sportTypeCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Attività (es. corsa, nuoto)',
                    ),
                  ),
                  TextField(
                    controller: durationCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Durata (minuti)',
                    ),
                  ),
                  DropdownButtonFormField<SportIntensity>(
                    initialValue: intensity,
                    decoration: const InputDecoration(labelText: 'Intensità'),
                    items: SportIntensity.values
                        .map(
                          (v) => DropdownMenuItem(
                            value: v,
                            child: Text(HealthLabels.intensity(v)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setDialog(() => intensity = v);
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Sessione: ${widget.dateOnlyFmt.format(scheduled)}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: scheduled,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setDialog(() => scheduled = picked);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          actions: [
            ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
            ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
          ],
        ),
      ),
    );

    if (ok != true || titleCtrl.text.trim().isEmpty) return;

    try {
      await widget.repo.create(
        familyId,
        widget.type,
        titleCtrl.text,
        description: descCtrl.text.trim().isEmpty ? null : descCtrl.text,
        scheduledAt: widget.type == HealthEntryType.diet
            ? null
            : scheduled,
        providerName: providerCtrl.text.trim().isEmpty
            ? null
            : providerCtrl.text,
        location:
            locationCtrl.text.trim().isEmpty ? null : locationCtrl.text,
        dietGoal:
            dietGoalCtrl.text.trim().isEmpty ? null : dietGoalCtrl.text,
        caloriesTarget: int.tryParse(caloriesCtrl.text),
        sportType:
            sportTypeCtrl.text.trim().isEmpty ? null : sportTypeCtrl.text,
        durationMinutes: int.tryParse(durationCtrl.text),
        intensity: widget.type == HealthEntryType.sportActivity
            ? intensity
            : null,
      );
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.repo.errorMessage(e))),
        );
      }
    }
  }

  String _subtitle(HealthEntry e) {
    final parts = <String>[HealthLabels.status(e.status)];
    if (e.type == HealthEntryType.medicalVisit) {
      if (e.providerName != null) parts.add(e.providerName!);
      if (e.scheduledAt != null) {
        parts.add(widget.dateFmt.format(e.scheduledAt!.toLocal()));
      }
    } else if (e.type == HealthEntryType.diet) {
      if (e.dietGoal != null) parts.add(e.dietGoal!);
      if (e.caloriesTarget != null) parts.add('${e.caloriesTarget} kcal');
    } else {
      if (e.sportType != null) parts.add(e.sportType!);
      if (e.durationMinutes != null) parts.add('${e.durationMinutes} min');
      if (e.intensity != null) parts.add(HealthLabels.intensity(e.intensity!));
      if (e.scheduledAt != null) {
        parts.add(widget.dateFmt.format(e.scheduledAt!.toLocal()));
      }
    }
    return parts.join(' · ');
  }

  IconData _icon(HealthEntry e) => switch (e.type) {
        HealthEntryType.medicalVisit => Icons.medical_services,
        HealthEntryType.diet => Icons.restaurant_menu,
        HealthEntryType.sportActivity => Icons.fitness_center,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: const Icon(Icons.add),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _items.isEmpty
                  ? ListView(
                      children: [
                        const SizedBox(height: 120),
                        Center(
                          child: Text(
                            'Nessuna ${HealthLabels.type(widget.type).toLowerCase()}',
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (_, i) {
                        final e = _items[i];
                        final canComplete = e.status != HealthEntryStatus.completed &&
                            e.status != HealthEntryStatus.cancelled &&
                            e.type != HealthEntryType.diet;
                        final isDiet = e.type == HealthEntryType.diet;
                        return ListTile(
                          leading: Icon(_icon(e)),
                          title: Text(e.title),
                          subtitle: Text(_subtitle(e)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isDiet && e.id != null)
                                IconButton(
                                  tooltip: 'Piano pasti',
                                  icon: const Icon(Icons.calendar_view_week_outlined),
                                  onPressed: () => context.push(
                                    AppRoutes.mealsWithDiet(e.id!),
                                  ),
                                ),
                              if (canComplete)
                                IconButton(
                                  icon: const Icon(Icons.check_circle_outline),
                                  onPressed: () async {
                                    try {
                                      await widget.repo.complete(e.id!);
                                      await _load();
                                    } catch (err) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              widget.repo.errorMessage(err),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                            ],
                          ),
                          onLongPress: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Eliminare?'),
                                content: Text(e.title),
                                actions: [
                                  ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
                                  ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Elimina')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              await widget.repo.delete(e.id!);
                              await _load();
                            }
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
