import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api/board_repository.dart';
import '../../core/api/calendar_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/expense_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/session/app_state.dart';

// ── Tipo attività ─────────────────────────────────────────────────────────

enum _Tipo {
  task(Icons.task_alt_outlined, 'Task', Colors.blue),
  appuntamento(Icons.event_outlined, 'Appuntamento', Colors.purple),
  spesa(Icons.payments_outlined, 'Spesa', Colors.orange),
  acquisto(Icons.shopping_cart_outlined, 'Acquisto', Colors.green),
  scadenza(Icons.alarm_outlined, 'Scadenza', Colors.red),
  medico(Icons.favorite_outline, 'Medico', Colors.pink);

  const _Tipo(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final MaterialColor color;
}

// ── Stato del form ────────────────────────────────────────────────────────

class _FormData {
  _Tipo? tipo;
  String titolo = '';
  String descrizione = '';
  TodoCategory categoria = TodoCategory.other;
  TodoPriority priorita = TodoPriority.medium;
  int? responsabile;     // userId
  int? destinatario;     // userId (null = tutta la famiglia)
  DateTime? quando;
  double? importo;
  bool tuttoFamiglia = true;
}

// ── Entry point ───────────────────────────────────────────────────────────

class NuovaAttivitaModal extends StatefulWidget {
  const NuovaAttivitaModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) => const NuovaAttivitaModal(),
    );
  }

  @override
  State<NuovaAttivitaModal> createState() => _NuovaAttivitaModalState();
}

class _NuovaAttivitaModalState extends State<NuovaAttivitaModal> {
  final _pageCtrl = PageController();
  final _data = _FormData();
  List<FamilyMemberInfo> _members = [];
  List<ShoppingList> _shoppingLists = [];
  bool _loading = false;
  int _step = 0; // 0=tipo 1=cosa 2=chi 3=quando 4=budget

  static const _steps = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMembers());
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadMembers() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    try {
      final results = await Future.wait([
        FamilyRepository().listMembers(familyId),
        ShoppingRepository().listLists(familyId),
      ]);
      if (mounted) {
        setState(() {
          _members = results[0] as List<FamilyMemberInfo>;
          _shoppingLists = results[1] as List<ShoppingList>;
        });
      }
    } catch (_) {}
  }

  void _goTo(int step) {
    setState(() => _step = step);
    _pageCtrl.animateToPage(
      step,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (_step == 0 && _data.tipo == null) return;
    final maxStep = _hasBudget ? 4 : 3;
    if (_step >= maxStep) {
      _submit();
    } else {
      _goTo(_step + 1);
    }
  }

  void _back() {
    if (_step > 0) _goTo(_step - 1);
  }

  bool get _hasBudget =>
      _data.tipo == _Tipo.spesa ||
      _data.tipo == _Tipo.scadenza ||
      _data.tipo == _Tipo.acquisto;

  bool get _hasWhen =>
      _data.tipo != _Tipo.acquisto;

  int get _totalSteps => _hasBudget ? 5 : 4;

  bool get _canNext {
    return switch (_step) {
      0 => _data.tipo != null,
      1 => _data.titolo.trim().isNotEmpty,
      _ => true,
    };
  }

  Future<void> _submit() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      await _save(familyId);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_data.tipo?.label ?? 'Attività'} aggiunta'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save(int familyId) async {
    final me = context.read<AppState>().signedInUser?.id;
    switch (_data.tipo!) {
      case _Tipo.task:
        await TodoRepository().create(
          familyId,
          _data.titolo.trim(),
          description: _data.descrizione.trim().isEmpty ? null : _data.descrizione.trim(),
          category: _data.categoria,
          priority: _data.priorita,
          assignedTo: _data.responsabile,
          dueDate: _data.quando,
        );
      case _Tipo.appuntamento:
        await CalendarRepository().create(
          familyId,
          _data.titolo.trim(),
          _data.quando ?? DateTime.now().add(const Duration(hours: 2)),
        );
      case _Tipo.spesa:
        await ExpenseRepository().create(
          familyId,
          _data.titolo.trim(),
          _data.importo ?? 0,
          _data.responsabile ?? me ?? 0,
        );
      case _Tipo.scadenza:
        await DeadlineRepository().create(
          familyId,
          _data.titolo.trim(),
          _data.quando ?? DateTime.now().add(const Duration(days: 30)),
          amount: _data.importo,
          category: DeadlineCategory.bill,
        );
      case _Tipo.acquisto:
        final repo = ShoppingRepository();
        int listId;
        if (_shoppingLists.isNotEmpty) {
          listId = _shoppingLists.first.id!;
        } else {
          final l = await repo.createList(familyId, 'Lista della spesa');
          listId = l.id!;
        }
        await repo.addItem(listId, _data.titolo.trim());
      case _Tipo.medico:
        await TodoRepository().create(
          familyId,
          _data.titolo.trim(),
          description: _data.descrizione.trim().isEmpty ? null : _data.descrizione.trim(),
          category: TodoCategory.other,
          priority: _data.priorita,
          assignedTo: _data.responsabile,
          dueDate: _data.quando,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final mq = MediaQuery.of(context);
    final isWide = mq.size.width >= 700;
    final sheetWidth = isWide ? 560.0 : double.infinity;

    return Center(
      child: Container(
        width: sheetWidth,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: scheme.outline.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  if (_step > 0)
                    IconButton(
                      onPressed: _back,
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  else
                    const SizedBox(width: 48),
                  Expanded(
                    child: Text(
                      _stepTitle,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annulla'),
                  ),
                ],
              ),
            ),
            // Progress dots
            _ProgressDots(current: _step, total: _totalSteps),
            const SizedBox(height: 8),
            // Pages
            SizedBox(
              height: _pageHeight,
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _StepTipo(selected: _data.tipo, onSelect: (t) { setState(() => _data.tipo = t); _next(); }),
                  _StepCosa(data: _data, members: _members, onChanged: () => setState(() {})),
                  _StepChi(data: _data, members: _members, onChanged: () => setState(() {})),
                  _StepQuando(data: _data, onChanged: () => setState(() {})),
                  if (_hasBudget)
                    _StepBudget(data: _data, onChanged: () => setState(() {})),
                ],
              ),
            ),
            // Bottom button
            if (_step > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: FilledButton(
                  onPressed: _canNext && !_loading ? _next : null,
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                  child: _loading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(_step >= _totalSteps - 1 ? 'Salva' : 'Avanti'),
                ),
              ),
            SizedBox(height: mq.padding.bottom),
          ],
        ),
      ),
    );
  }

  String get _stepTitle => switch (_step) {
        0 => 'Nuova attività',
        1 => _data.tipo?.label ?? 'Dettagli',
        2 => 'Per chi?',
        3 => 'Quando?',
        4 => 'Importo',
        _ => '',
      };

  double get _pageHeight => switch (_step) {
        0 => 280,
        2 => _members.length * 64.0 + 180,
        3 => 340,
        _ => 260,
      };
}

// ── Step 0 — Tipo ─────────────────────────────────────────────────────────

class _StepTipo extends StatelessWidget {
  const _StepTipo({required this.selected, required this.onSelect});
  final _Tipo? selected;
  final void Function(_Tipo) onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.15,
        children: _Tipo.values.map((t) {
          final sel = selected == t;
          return _TipoTile(tipo: t, selected: sel, onTap: () => onSelect(t));
        }).toList(),
      ),
    );
  }
}

class _TipoTile extends StatelessWidget {
  const _TipoTile({required this.tipo, required this.selected, required this.onTap});
  final _Tipo tipo;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = Color(tipo.color.value);
    return Material(
      color: selected ? color.withValues(alpha: 0.18) : scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tipo.icon, color: color, size: 30),
              const SizedBox(height: 6),
              Text(
                tipo.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  color: selected ? color : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Step 1 — Cosa ─────────────────────────────────────────────────────────

class _StepCosa extends StatelessWidget {
  const _StepCosa({required this.data, required this.members, required this.onChanged});
  final _FormData data;
  final List<FamilyMemberInfo> members;
  final VoidCallback onChanged;

  String get _titoloHint => switch (data.tipo) {
        _Tipo.task => 'Es. Fare la spesa',
        _Tipo.appuntamento => 'Es. Visita dal dentista',
        _Tipo.spesa => 'Es. Cena al ristorante',
        _Tipo.acquisto => 'Es. Latte, pane...',
        _Tipo.scadenza => 'Es. Bolletta luce',
        _Tipo.medico => 'Es. Visita pediatrica Luca',
        _ => 'Titolo',
      };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: _titoloHint, labelText: 'Titolo'),
            onChanged: (v) { data.titolo = v; onChanged(); },
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Note aggiuntive (opzionale)',
              labelText: 'Descrizione',
            ),
            maxLines: 2,
            onChanged: (v) { data.descrizione = v; onChanged(); },
            textCapitalization: TextCapitalization.sentences,
          ),
          if (data.tipo == _Tipo.task) ...[
            const SizedBox(height: 16),
            _PrioritaSelector(
              value: data.priorita,
              onChanged: (p) { data.priorita = p; onChanged(); },
            ),
          ],
        ],
      ),
    );
  }
}

class _PrioritaSelector extends StatelessWidget {
  const _PrioritaSelector({required this.value, required this.onChanged});
  final TodoPriority value;
  final void Function(TodoPriority) onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Priorità', style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        SegmentedButton<TodoPriority>(
          segments: const [
            ButtonSegment(value: TodoPriority.low, label: Text('Bassa')),
            ButtonSegment(value: TodoPriority.medium, label: Text('Media')),
            ButtonSegment(value: TodoPriority.high, label: Text('Alta')),
            ButtonSegment(value: TodoPriority.critical, icon: Icon(Icons.warning_amber_rounded, size: 16), label: Text('Urgente')),
          ],
          selected: {value},
          onSelectionChanged: (s) => onChanged(s.first),
          style: ButtonStyle(
            visualDensity: const VisualDensity(horizontal: -3, vertical: -2),
            textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.labelSmall),
          ),
        ),
      ],
    );
  }
}

// ── Step 2 — Chi ──────────────────────────────────────────────────────────

class _StepChi extends StatelessWidget {
  const _StepChi({required this.data, required this.members, required this.onChanged});
  final _FormData data;
  final List<FamilyMemberInfo> members;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Destinatario
          Row(
            children: [
              Icon(Icons.people_outline, size: 18, color: scheme.primary),
              const SizedBox(width: 8),
              Text('Riguarda', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          _ChoiceChip(
            label: 'Tutta la famiglia',
            icon: Icons.family_restroom,
            selected: data.tuttoFamiglia,
            onTap: () { data.tuttoFamiglia = true; data.destinatario = null; onChanged(); },
          ),
          const SizedBox(height: 6),
          for (final m in members)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _ChoiceChip(
                label: m.displayName,
                icon: Icons.person_outline,
                selected: !data.tuttoFamiglia && data.destinatario == m.userId,
                onTap: () { data.tuttoFamiglia = false; data.destinatario = m.userId; onChanged(); },
                avatar: m.displayName[0].toUpperCase(),
              ),
            ),
          if (members.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            // Responsabile
            Row(
              children: [
                Icon(Icons.engineering_outlined, size: 18, color: scheme.primary),
                const SizedBox(width: 8),
                Text('Chi lo fa', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            _ChoiceChip(
              label: 'Non assegnato',
              icon: Icons.person_off_outlined,
              selected: data.responsabile == null,
              onTap: () { data.responsabile = null; onChanged(); },
            ),
            const SizedBox(height: 6),
            for (final m in members)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _ChoiceChip(
                  label: m.displayName,
                  icon: Icons.person_outline,
                  selected: data.responsabile == m.userId,
                  onTap: () { data.responsabile = m.userId; onChanged(); },
                  avatar: m.displayName[0].toUpperCase(),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({required this.label, required this.icon, required this.selected, required this.onTap, this.avatar});
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected ? scheme.primary.withValues(alpha: 0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? scheme.primary.withValues(alpha: 0.6) : scheme.outline.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              if (avatar != null)
                CircleAvatar(
                  radius: 14,
                  backgroundColor: selected ? scheme.primary : scheme.outline.withValues(alpha: 0.2),
                  child: Text(avatar!, style: TextStyle(fontSize: 12, color: selected ? scheme.onPrimary : null)),
                )
              else
                Icon(icon, size: 20, color: selected ? scheme.primary : scheme.onSurface.withValues(alpha: 0.55)),
              const SizedBox(width: 10),
              Expanded(child: Text(label, style: TextStyle(fontWeight: selected ? FontWeight.w600 : FontWeight.normal))),
              if (selected) Icon(Icons.check_circle, size: 18, color: scheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Step 3 — Quando ───────────────────────────────────────────────────────

class _StepQuando extends StatefulWidget {
  const _StepQuando({required this.data, required this.onChanged});
  final _FormData data;
  final VoidCallback onChanged;

  @override
  State<_StepQuando> createState() => _StepQuandoState();
}

class _StepQuandoState extends State<_StepQuando> {
  final _fmt = (DateTime d) => '${d.day}/${d.month}/${d.year}  ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final init = widget.data.quando ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (date == null) return;
    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(init),
    );
    setState(() {
      widget.data.quando = DateTime(date.year, date.month, date.day,
          time?.hour ?? init.hour, time?.minute ?? init.minute);
    });
    widget.onChanged();
  }

  void _clearDate() {
    setState(() => widget.data.quando = null);
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final d = widget.data.quando;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selezione data
          GestureDetector(
            onTap: _pickDate,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: d != null ? scheme.primary.withValues(alpha: 0.08) : scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: d != null ? scheme.primary.withValues(alpha: 0.4) : scheme.outline.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined, color: d != null ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      d != null ? _fmt(d) : 'Seleziona data e ora',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: d != null ? FontWeight.w600 : FontWeight.normal,
                        color: d != null ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  if (d != null)
                    IconButton(
                      icon: Icon(Icons.close, size: 18, color: scheme.onSurface.withValues(alpha: 0.4)),
                      onPressed: _clearDate,
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Promemoria (coming soon)
          _ComingSoon(
            icon: Icons.notifications_outlined,
            label: 'Promemoria',
            subtitle: '1 giorno prima, 1 ora prima...',
          ),
          const SizedBox(height: 10),
          // Ripeti (coming soon)
          _ComingSoon(
            icon: Icons.repeat_rounded,
            label: 'Ripeti ogni',
            subtitle: 'Giornaliero, settimanale, mensile...',
          ),
        ],
      ),
    );
  }
}

// ── Step 4 — Budget ───────────────────────────────────────────────────────

class _StepBudget extends StatefulWidget {
  const _StepBudget({required this.data, required this.onChanged});
  final _FormData data;
  final VoidCallback onChanged;

  @override
  State<_StepBudget> createState() => _StepBudgetState();
}

class _StepBudgetState extends State<_StepBudget> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.data.importo != null ? widget.data.importo!.toStringAsFixed(2) : '',
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _ctrl,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Importo',
              prefixText: '€ ',
              hintText: '0.00',
            ),
            onChanged: (v) {
              widget.data.importo = double.tryParse(v.replaceAll(',', '.'));
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),
          // Conto di addebito (coming soon)
          _ComingSoon(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Conto di addebito',
            subtitle: 'Cassa famiglia / Personale / Split...',
          ),
          const SizedBox(height: 10),
          // Approvazione spesa (coming soon)
          _ComingSoon(
            icon: Icons.how_to_vote_outlined,
            label: 'Richiede approvazione',
            subtitle: 'Notifica agli altri membri per conferma',
          ),
        ],
      ),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.current, required this.total});
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 20 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: active ? scheme.primary : scheme.outline.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.icon, required this.label, required this.subtitle});
  final IconData icon;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Opacity(
      opacity: 0.45,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outline.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: scheme.onSurface.withValues(alpha: 0.5)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                  Text(subtitle, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: scheme.outline.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('Presto', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
