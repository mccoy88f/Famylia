import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/calendar_repository.dart';
import '../../core/api/deadline_repository.dart';
import '../../core/api/expense_repository.dart';
import '../../core/api/family_repository.dart';
import '../../core/api/shopping_repository.dart';
import '../../core/api/todo_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/session/app_state.dart';
import '../../core/utils/registra_spesa_dialog.dart';

// ── Tipo attività ─────────────────────────────────────────────────────────

enum _Tipo {
  task(Icons.task_alt_outlined, 'Task', Color(0xFF3B82F6)),
  appuntamento(Icons.event_outlined, 'Appuntamento', Color(0xFF8B5CF6)),
  spesa(Icons.payments_outlined, 'Spesa', Color(0xFFF59E0B)),
  acquisto(Icons.shopping_cart_outlined, 'Acquisto', Color(0xFF10B981)),
  scadenza(Icons.alarm_outlined, 'Scadenza', Color(0xFFEF4444));

  const _Tipo(this.icon, this.label, this.color);
  final IconData icon;
  final String label;
  final Color color;
}

// ── Sottotipo appuntamento ────────────────────────────────────────────────

enum _TipoAppuntamento {
  generico('Generico', Icons.event_outlined),
  medico('Medico', Icons.favorite_outline),
  dentista('Dentista', Icons.medical_services_outlined),
  altro('Altro', Icons.more_horiz_outlined);

  const _TipoAppuntamento(this.label, this.icon);
  final String label;
  final IconData icon;
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
  _TipoAppuntamento tipoAppuntamento = _TipoAppuntamento.generico;
  // Spese condivise
  int? pagatoreId;
  List<int> beneficiariIds = []; // vuoto = tutta la famiglia
  // Costo preventivato (solo task/appuntamento)
  double? costoPreventivato;
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

  String? _buildDescription(String base) {
    if (_data.costoPreventivato != null && _data.costoPreventivato! > 0) {
      return encodePreventivato(base, _data.costoPreventivato!);
    }
    return base.isEmpty ? null : base;
  }

  Future<void> _save(int familyId) async {
    final me = context.read<AppState>().signedInUser?.id;
    switch (_data.tipo!) {
      case _Tipo.task:
        await TodoRepository().create(
          familyId,
          _data.titolo.trim(),
          description: _buildDescription(_data.descrizione.trim()),
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
          description: _buildDescription(_data.descrizione.trim()),
        );
      case _Tipo.spesa:
        final pagatore = _data.pagatoreId ?? me ?? 0;
        await ExpenseRepository().create(
          familyId,
          _data.titolo.trim(),
          _data.importo ?? 0,
          pagatore,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final mq = MediaQuery.of(context);
    final isWide = mq.size.width >= 700;
    final sheetWidth = isWide ? 720.0 : double.infinity;
    final borderRadius = isWide
        ? BorderRadius.circular(16)
        : const BorderRadius.vertical(top: Radius.circular(20));
    final pageHeight = (mq.size.height * 0.55).clamp(300.0, 500.0);

    return Center(
      child: Container(
        width: sheetWidth,
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.92),
        decoration: BoxDecoration(
          color: shadTheme.colorScheme.background,
          borderRadius: borderRadius,
          border: Border.all(color: shadTheme.colorScheme.border),
        ),
        padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle (mobile only)
            if (!isWide) ...[
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
            ] else
              const SizedBox(height: 16),
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
            // Step indicator
            if (_step > 0) ...[
              const SizedBox(height: 12),
              _StepIndicator(
                current: _step,
                total: _totalSteps - 1,
                shadTheme: shadTheme,
              ),
            ],
            const SizedBox(height: 12),
            // Pages
            SizedBox(
              height: pageHeight,
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _StepTipo(selected: _data.tipo, onSelect: (t) { setState(() => _data.tipo = t); _next(); }),
                  _StepCosa(data: _data, members: _members, onChanged: () => setState(() {})),
                  _StepChi(data: _data, members: _members, onChanged: () => setState(() {})),
                  _StepQuando(data: _data, onChanged: () => setState(() {})),
                  if (_hasBudget)
                    _StepBudget(data: _data, members: _members, onChanged: () => setState(() {})),
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
              )
            else
              const SizedBox(height: 8),
            SizedBox(height: mq.padding.bottom),
          ],
        ),
      ),
    );
  }

  String get _stepTitle => switch (_step) {
        0 => 'Nuova attività',
        1 => _data.tipo?.label ?? 'Dettagli',
        2 => _data.tipo == _Tipo.spesa ? 'Chi paga?' : 'Per chi?',
        3 => 'Quando?',
        4 => 'Importo',
        _ => '',
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.2,
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
          if (data.tipo == _Tipo.appuntamento) ...[
            const SizedBox(height: 16),
            Text('Tipo appuntamento', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            _TipoAppuntamentoRow(value: data.tipoAppuntamento, onChanged: (t) { data.tipoAppuntamento = t; onChanged(); }),
          ],
          if (data.tipo == _Tipo.task || data.tipo == _Tipo.appuntamento) ...[
            const SizedBox(height: 20),
            Divider(color: ShadTheme.of(context).colorScheme.border),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.euro_outlined, size: 14, color: shadTheme.colorScheme.mutedForeground),
                const SizedBox(width: 6),
                Text('Costo preventivato', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(width: 6),
                Text('(opzionale)', style: shadTheme.textTheme.muted.copyWith(fontSize: 11)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Ti verrà chiesto il costo effettivo al completamento',
              style: shadTheme.textTheme.muted.copyWith(fontSize: 11),
            ),
            const SizedBox(height: 8),
            _CampoPreventivato(data: data, onChanged: onChanged),
          ],
        ],
      ),
    );
  }
}

class _CampoPreventivato extends StatefulWidget {
  const _CampoPreventivato({required this.data, required this.onChanged});
  final _FormData data;
  final VoidCallback onChanged;

  @override
  State<_CampoPreventivato> createState() => _CampoPreventivatiState();
}

class _CampoPreventivatiState extends State<_CampoPreventivato> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.data.costoPreventivato != null
          ? widget.data.costoPreventivato!.toStringAsFixed(2)
          : '',
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
    return ShadInput(
      controller: _ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      placeholder: const Text('0.00'),
      leading: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text('€', style: shadTheme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
      ),
      onChanged: (v) {
        widget.data.costoPreventivato = double.tryParse(v.replaceAll(',', '.'));
        widget.onChanged();
      },
    );
  }
}

class _TipoAppuntamentoRow extends StatelessWidget {
  const _TipoAppuntamentoRow({required this.value, required this.onChanged});
  final _TipoAppuntamento value;
  final void Function(_TipoAppuntamento) onChanged;

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _TipoAppuntamento.values.map((t) {
        final sel = value == t;
        final primary = shadTheme.colorScheme.primary;
        return GestureDetector(
          onTap: () => onChanged(t),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: sel ? primary.withValues(alpha: 0.10) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: sel ? primary.withValues(alpha: 0.5) : shadTheme.colorScheme.border,
                width: sel ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(t.icon, size: 14, color: sel ? primary : shadTheme.colorScheme.mutedForeground),
                const SizedBox(width: 6),
                Text(
                  t.label,
                  style: shadTheme.textTheme.small.copyWith(
                    color: sel ? primary : shadTheme.colorScheme.foreground,
                    fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
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
    if (data.tipo == _Tipo.spesa) {
      return _StepChiSpesa(data: data, members: members, onChanged: onChanged);
    }
    return _StepChiGenerica(data: data, members: members, onChanged: onChanged);
  }
}

class _StepChiGenerica extends StatelessWidget {
  const _StepChiGenerica({required this.data, required this.members, required this.onChanged});
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

class _StepChiSpesa extends StatelessWidget {
  const _StepChiSpesa({required this.data, required this.members, required this.onChanged});
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
              Icon(Icons.payments_outlined, size: 16, color: shadTheme.colorScheme.primary),
              const SizedBox(width: 6),
              Text('Chi ha pagato', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          if (members.isEmpty)
            Text('Nessun membro trovato', style: shadTheme.textTheme.muted)
          else
            for (final m in members)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _ChoiceRow(
                  label: m.displayName,
                  icon: Icons.person_outline,
                  selected: data.pagatoreId == m.userId,
                  onTap: () { data.pagatoreId = m.userId; onChanged(); },
                  avatar: m.displayName[0].toUpperCase(),
                  shadTheme: shadTheme,
                ),
              ),
          const SizedBox(height: 16),
          Divider(color: shadTheme.colorScheme.border),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.group_outlined, size: 16, color: shadTheme.colorScheme.primary),
              const SizedBox(width: 6),
              Text('A carico di', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Seleziona chi divide questa spesa',
            style: shadTheme.textTheme.muted.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          _MultiChoiceRow(
            label: 'Tutta la famiglia',
            icon: Icons.family_restroom,
            selected: data.beneficiariIds.isEmpty,
            onTap: () { data.beneficiariIds = []; onChanged(); },
            shadTheme: shadTheme,
          ),
          const SizedBox(height: 6),
          if (members.isNotEmpty)
            for (final m in members)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: _MultiChoiceRow(
                  label: m.displayName,
                  icon: Icons.person_outline,
                  selected: data.beneficiariIds.contains(m.userId),
                  onTap: () {
                    if (data.beneficiariIds.contains(m.userId)) {
                      data.beneficiariIds.remove(m.userId);
                    } else {
                      data.beneficiariIds.add(m.userId);
                    }
                    onChanged();
                  },
                  avatar: m.displayName[0].toUpperCase(),
                  shadTheme: shadTheme,
                ),
              ),
        ],
      ),
    );
  }
}

class _MultiChoiceRow extends StatelessWidget {
  const _MultiChoiceRow({
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
            AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 20, height: 20,
              decoration: BoxDecoration(
                color: selected ? primary : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: selected ? primary : shadTheme.colorScheme.border),
              ),
              child: selected ? Icon(Icons.check, size: 13, color: shadTheme.colorScheme.primaryForeground) : null,
            ),
          ],
        ),
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

    return SingleChildScrollView(
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
  const _StepBudget({required this.data, required this.members, required this.onChanged});
  final _FormData data;
  final List<FamilyMemberInfo> members;
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

  String get _splitSummary {
    if (widget.data.beneficiariIds.isEmpty) return 'Tutta la famiglia';
    final nomi = widget.data.beneficiariIds
        .map((id) => widget.members.firstWhere((m) => m.userId == id, orElse: () => widget.members.first).displayName)
        .join(', ');
    return nomi;
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final hasBeneficiari = widget.data.beneficiariIds.isNotEmpty;
    final count = hasBeneficiari ? widget.data.beneficiariIds.length : null;
    final importo = widget.data.importo;
    final splitAmount = (importo != null && count != null && count > 0)
        ? importo / count
        : null;

    return SingleChildScrollView(
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
          if (importo != null && importo > 0) ...[
            const SizedBox(height: 16),
            ShadCard(
              padding: const EdgeInsets.all(12),
              backgroundColor: shadTheme.colorScheme.muted.withValues(alpha: 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_outlined, size: 14, color: shadTheme.colorScheme.mutedForeground),
                      const SizedBox(width: 6),
                      Text('Riepilogo', style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (widget.data.pagatoreId != null) ...[
                    _SummaryRow(
                      label: 'Pagato da',
                      value: widget.members
                          .firstWhere((m) => m.userId == widget.data.pagatoreId, orElse: () => widget.members.first)
                          .displayName,
                      shadTheme: shadTheme,
                    ),
                    const SizedBox(height: 4),
                  ],
                  _SummaryRow(label: 'A carico di', value: _splitSummary, shadTheme: shadTheme),
                  if (splitAmount != null) ...[
                    const SizedBox(height: 4),
                    _SummaryRow(
                      label: 'Quota per persona',
                      value: '€ ${splitAmount.toStringAsFixed(2)}',
                      shadTheme: shadTheme,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, required this.shadTheme});
  final String label;
  final String value;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: shadTheme.textTheme.small.copyWith(color: shadTheme.colorScheme.mutedForeground)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current, required this.total, required this.shadTheme});
  final int current;
  final int total;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? current / total : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Passo $current di $total',
                style: shadTheme.textTheme.small.copyWith(
                  color: shadTheme.colorScheme.mutedForeground,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Container(
              height: 3,
              width: double.infinity,
              color: shadTheme.colorScheme.border,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: Container(color: shadTheme.colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
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
