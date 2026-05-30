import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  task(Icons.task_alt_outlined, 'Task', Color(0xFF3B82F6)),
  appuntamento(Icons.event_outlined, 'Appuntamento', Color(0xFF8B5CF6)),
  spesa(Icons.payments_outlined, 'Spesa', Color(0xFFF59E0B)),
  acquisto(Icons.shopping_cart_outlined, 'Acquisto', Color(0xFF10B981)),
  scadenza(Icons.alarm_outlined, 'Scadenza', Color(0xFFEF4444)),
  medico(Icons.favorite_outline, 'Medico', Color(0xFFEC4899));

  const _Tipo(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;
}

// ── Stato del form ────────────────────────────────────────────────────────

class _FormData {
  _Tipo? tipo;
  String titolo = '';
  String descrizione = '';
  TodoCategory categoria = TodoCategory.other;
  TodoPriority priorita = TodoPriority.medium;
  int? responsabile;
  int? destinatario;
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
  int _step = 0;

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

  int get _totalSteps => _hasBudget ? 5 : 4;

  bool get _canNext => switch (_step) {
        0 => _data.tipo != null,
        1 => _data.titolo.trim().isNotEmpty,
        _ => true,
      };

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
    final shadTheme = ShadTheme.of(context);
    final mq = MediaQuery.of(context);
    final isWide = mq.size.width >= 700;
    final sheetWidth = isWide ? 560.0 : double.infinity;

    return Center(
      child: Container(
        width: sheetWidth,
        decoration: BoxDecoration(
          color: shadTheme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(
            top: BorderSide(color: shadTheme.colorScheme.border),
            left: isWide ? BorderSide(color: shadTheme.colorScheme.border) : BorderSide.none,
            right: isWide ? BorderSide(color: shadTheme.colorScheme.border) : BorderSide.none,
          ),
        ),
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                  color: shadTheme.colorScheme.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 0),
              child: Row(
                children: [
                  if (_step > 0)
                    ShadButton.ghost(
                      onPressed: _back,
                      size: ShadButtonSize.icon,
                      child: const Icon(Icons.arrow_back_rounded, size: 18),
                    )
                  else
                    const SizedBox(width: 44),
                  Expanded(
                    child: Text(
                      _stepTitle,
                      style: shadTheme.textTheme.h4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ShadButton.ghost(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annulla'),
                  ),
                ],
              ),
            ),
            // Progress dots
            const SizedBox(height: 8),
            _ProgressDots(current: _step, total: _totalSteps, colorScheme: shadTheme.colorScheme),
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
                child: ShadButton(
                  onPressed: _canNext && !_loading ? _next : null,
                  width: double.infinity,
                  child: _loading
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
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
    final shadTheme = ShadTheme.of(context);
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
          return _TipoTile(tipo: t, selected: sel, onTap: () => onSelect(t), shadTheme: shadTheme);
        }).toList(),
      ),
    );
  }
}

class _TipoTile extends StatelessWidget {
  const _TipoTile({required this.tipo, required this.selected, required this.onTap, required this.shadTheme});
  final _Tipo tipo;
  final bool selected;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final color = tipo.color;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.12) : shadTheme.colorScheme.muted.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? color : shadTheme.colorScheme.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tipo.icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              tipo.label,
              style: shadTheme.textTheme.small.copyWith(
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? color : shadTheme.colorScheme.foreground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
    final shadTheme = ShadTheme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInput(
            placeholder: Text(_titoloHint),
            autofocus: true,
            onChanged: (v) { data.titolo = v; onChanged(); },
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 12),
          ShadInput(
            placeholder: const Text('Note aggiuntive (opzionale)'),
            maxLines: 2,
            onChanged: (v) { data.descrizione = v; onChanged(); },
            textCapitalization: TextCapitalization.sentences,
          ),
          if (data.tipo == _Tipo.task) ...[
            const SizedBox(height: 16),
            Text('Priorità', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            _PrioritaRow(value: data.priorita, onChanged: (p) { data.priorita = p; onChanged(); }),
          ],
        ],
      ),
    );
  }
}

class _PrioritaRow extends StatelessWidget {
  const _PrioritaRow({required this.value, required this.onChanged});
  final TodoPriority value;
  final void Function(TodoPriority) onChanged;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Row(
      children: [
        for (final p in TodoPriority.values)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: p == TodoPriority.values.last ? 0 : 6),
              child: _PrioritaChip(
                priority: p,
                selected: value == p,
                onTap: () => onChanged(p),
                shadTheme: shadTheme,
              ),
            ),
          ),
      ],
    );
  }
}

class _PrioritaChip extends StatelessWidget {
  const _PrioritaChip({required this.priority, required this.selected, required this.onTap, required this.shadTheme});
  final TodoPriority priority;
  final bool selected;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;

  Color get _color => switch (priority) {
        TodoPriority.low => const Color(0xFF6B7280),
        TodoPriority.medium => const Color(0xFF3B82F6),
        TodoPriority.high => const Color(0xFFF59E0B),
        TodoPriority.critical => const Color(0xFFEF4444),
        _ => const Color(0xFF6B7280),
      };

  String get _label => switch (priority) {
        TodoPriority.low => 'Bassa',
        TodoPriority.medium => 'Media',
        TodoPriority.high => 'Alta',
        TodoPriority.critical => 'Urgente',
        _ => '',
      };

  @override
  Widget build(BuildContext context) {
    final c = _color;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.12) : shadTheme.colorScheme.muted.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? c : shadTheme.colorScheme.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          _label,
          textAlign: TextAlign.center,
          style: shadTheme.textTheme.small.copyWith(
            fontSize: 11,
            color: selected ? c : shadTheme.colorScheme.mutedForeground,
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
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
    final shadTheme = ShadTheme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people_outline, size: 16, color: shadTheme.colorScheme.primary),
              const SizedBox(width: 6),
              Text('Riguarda', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          _ChoiceRow(
            label: 'Tutta la famiglia',
            icon: Icons.family_restroom,
            selected: data.tuttoFamiglia,
            onTap: () { data.tuttoFamiglia = true; data.destinatario = null; onChanged(); },
            shadTheme: shadTheme,
          ),
          const SizedBox(height: 6),
          for (final m in members)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _ChoiceRow(
                label: m.displayName,
                icon: Icons.person_outline,
                selected: !data.tuttoFamiglia && data.destinatario == m.userId,
                onTap: () { data.tuttoFamiglia = false; data.destinatario = m.userId; onChanged(); },
                avatar: m.displayName[0].toUpperCase(),
                shadTheme: shadTheme,
              ),
            ),
          if (members.isNotEmpty) ...[
            const SizedBox(height: 16),
            Divider(color: shadTheme.colorScheme.border),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.engineering_outlined, size: 16, color: shadTheme.colorScheme.primary),
                const SizedBox(width: 6),
                Text('Chi lo fa', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: 'Non assegnato',
              icon: Icons.person_off_outlined,
              selected: data.responsabile == null,
              onTap: () { data.responsabile = null; onChanged(); },
              shadTheme: shadTheme,
            ),
            const SizedBox(height: 6),
            for (final m in members)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _ChoiceRow(
                  label: m.displayName,
                  icon: Icons.person_outline,
                  selected: data.responsabile == m.userId,
                  onTap: () { data.responsabile = m.userId; onChanged(); },
                  avatar: m.displayName[0].toUpperCase(),
                  shadTheme: shadTheme,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    required this.shadTheme,
    this.avatar,
  });
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    final primary = shadTheme.colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? primary.withValues(alpha: 0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? primary.withValues(alpha: 0.5) : shadTheme.colorScheme.border,
          ),
        ),
        child: Row(
          children: [
            if (avatar != null)
              CircleAvatar(
                radius: 14,
                backgroundColor: selected ? primary : shadTheme.colorScheme.muted,
                child: Text(avatar!,
                    style: TextStyle(fontSize: 12, color: selected ? shadTheme.colorScheme.primaryForeground : shadTheme.colorScheme.mutedForeground)),
              )
            else
              Icon(icon, size: 18, color: selected ? primary : shadTheme.colorScheme.mutedForeground),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: shadTheme.textTheme.p.copyWith(fontWeight: selected ? FontWeight.w600 : FontWeight.normal))),
            if (selected) Icon(Icons.check, size: 16, color: primary),
          ],
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
  String _fmt(DateTime d) =>
      '${d.day}/${d.month}/${d.year}  ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final init = widget.data.quando ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (date == null || !mounted) return;
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
    final shadTheme = ShadTheme.of(context);
    final d = widget.data.quando;
    final primary = shadTheme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickDate,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: d != null ? primary.withValues(alpha: 0.08) : shadTheme.colorScheme.muted.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: d != null ? primary.withValues(alpha: 0.4) : shadTheme.colorScheme.border,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      color: d != null ? primary : shadTheme.colorScheme.mutedForeground,
                      size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      d != null ? _fmt(d) : 'Seleziona data e ora',
                      style: shadTheme.textTheme.p.copyWith(
                        fontWeight: d != null ? FontWeight.w600 : FontWeight.normal,
                        color: d != null ? primary : shadTheme.colorScheme.mutedForeground,
                      ),
                    ),
                  ),
                  if (d != null)
                    GestureDetector(
                      onTap: _clearDate,
                      child: Icon(Icons.close, size: 16, color: shadTheme.colorScheme.mutedForeground),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _ComingSoon(icon: Icons.notifications_outlined, label: 'Promemoria', subtitle: '1 giorno prima, 1 ora prima...', shadTheme: shadTheme),
          const SizedBox(height: 10),
          _ComingSoon(icon: Icons.repeat_rounded, label: 'Ripeti ogni', subtitle: 'Giornaliero, settimanale, mensile...', shadTheme: shadTheme),
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
    final shadTheme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInput(
            controller: _ctrl,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            placeholder: const Text('0.00'),
            leading: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text('€', style: shadTheme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
            ),
            onChanged: (v) {
              widget.data.importo = double.tryParse(v.replaceAll(',', '.'));
              widget.onChanged();
            },
          ),
          const SizedBox(height: 16),
          _ComingSoon(icon: Icons.account_balance_wallet_outlined, label: 'Conto di addebito', subtitle: 'Cassa famiglia / Personale / Split...', shadTheme: shadTheme),
          const SizedBox(height: 10),
          _ComingSoon(icon: Icons.how_to_vote_outlined, label: 'Richiede approvazione', subtitle: 'Notifica agli altri membri per conferma', shadTheme: shadTheme),
        ],
      ),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.current, required this.total, required this.colorScheme});
  final int current;
  final int total;
  final ShadColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
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
            color: active ? colorScheme.primary : colorScheme.border,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.icon, required this.label, required this.subtitle, required this.shadTheme});
  final IconData icon;
  final String label;
  final String subtitle;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.45,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: shadTheme.colorScheme.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: shadTheme.colorScheme.mutedForeground),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
                  Text(subtitle, style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: shadTheme.colorScheme.muted,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text('Presto', style: shadTheme.textTheme.muted.copyWith(fontSize: 10, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
