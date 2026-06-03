import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/family_repository.dart';
import '../../core/api/gamification_repository.dart';
import '../../core/api/goal_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/session/app_state.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final _repo = GoalRepository();
  final _gamRepo = GamificationRepository();
  final _famRepo = FamilyRepository();

  List<FamilyGoal> _goals = [];
  List<FamilyMemberInfo> _members = [];
  UserPoints? _myPoints;
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
      final results = await Future.wait([
        _repo.listGoals(familyId),
        _famRepo.listMembers(familyId),
        _gamRepo.myPoints(familyId),
      ]);
      if (mounted) {
        setState(() {
          _goals = results[0] as List<FamilyGoal>;
          _members = results[1] as List<FamilyMemberInfo>;
          _myPoints = results[2] as UserPoints;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _memberName(int userId) {
    final m = _members.where((m) => m.userId == userId).firstOrNull;
    return m?.displayName ?? 'Utente #$userId';
  }

  Future<void> _showCreate() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final myId = context.read<AppState>().signedInUser?.id;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CreateGoalSheet(
        members: _members,
        myUserId: myId,
        onSave: (targetUserId, title, targetPoints, reward, desc, deadline) async {
          await _repo.createGoal(
            familyId: familyId,
            targetUserId: targetUserId,
            title: title,
            targetPoints: targetPoints,
            rewardAmount: reward,
            description: desc,
            deadline: deadline,
          );
          await _load();
        },
      ),
    );
  }

  Future<void> _cancel(FamilyGoal goal) async {
    final s = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(s.goalsCancel),
        content: Text('Vuoi annullare l\'obiettivo "${goal.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(s.goalsCancel, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm != true) return;
    try {
      await _repo.cancelGoal(goal.id!);
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
    }
  }

  Future<void> _markPaid(FamilyGoal goal) async {
    try {
      await _repo.markPaid(goal.id!);
      await _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_repo.errorMessage(e))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    final s = AppLocalizations.of(context);
    final myId = context.watch<AppState>().signedInUser?.id;

    final active = _goals.where((g) => g.status == FamilyGoalStatus.active).toList();
    final completed = _goals.where((g) => g.status == FamilyGoalStatus.completed).toList();
    final cancelled = _goals.where((g) => g.status == FamilyGoalStatus.cancelled).toList();

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text(s.goalsTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ShadButton.ghost(
              onPressed: _showCreate,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _goals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.emoji_events_outlined, size: 56, color: shadTheme.colorScheme.mutedForeground),
                          const SizedBox(height: 16),
                          Text(s.goalsEmpty, style: shadTheme.textTheme.muted, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ShadButton(
                            onPressed: _showCreate,
                            child: Text(s.goalsCreate),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        if (active.isNotEmpty) ...[
                          _SectionLabel(s.goalsActive, shadTheme),
                          const SizedBox(height: 8),
                          for (final goal in active)
                            _GoalCard(
                              goal: goal,
                              memberName: _memberName(goal.targetUserId),
                              creatorName: _memberName(goal.createdBy),
                              currentPoints: goal.targetUserId == myId ? (_myPoints?.points ?? 0) : null,
                              myId: myId,
                              shadTheme: shadTheme,
                              onCancel: () => _cancel(goal),
                              onMarkPaid: null,
                            ),
                          const SizedBox(height: 16),
                        ],
                        if (completed.isNotEmpty) ...[
                          _SectionLabel(s.goalsCompleted, shadTheme),
                          const SizedBox(height: 8),
                          for (final goal in completed)
                            _GoalCard(
                              goal: goal,
                              memberName: _memberName(goal.targetUserId),
                              creatorName: _memberName(goal.createdBy),
                              currentPoints: null,
                              myId: myId,
                              shadTheme: shadTheme,
                              onCancel: null,
                              onMarkPaid: goal.paidAt == null && goal.createdBy == myId
                                  ? () => _markPaid(goal)
                                  : null,
                            ),
                          const SizedBox(height: 16),
                        ],
                        if (cancelled.isNotEmpty) ...[
                          _SectionLabel(s.goalsCancelled, shadTheme),
                          const SizedBox(height: 8),
                          for (final goal in cancelled)
                            _GoalCard(
                              goal: goal,
                              memberName: _memberName(goal.targetUserId),
                              creatorName: _memberName(goal.createdBy),
                              currentPoints: null,
                              myId: myId,
                              shadTheme: shadTheme,
                              onCancel: null,
                              onMarkPaid: null,
                            ),
                        ],
                      ],
                    ),
            ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label, this.shadTheme);
  final String label;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(label.toUpperCase(), style: shadTheme.textTheme.muted.copyWith(
        fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5,
      )),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.memberName,
    required this.creatorName,
    required this.currentPoints,
    required this.myId,
    required this.shadTheme,
    required this.onCancel,
    required this.onMarkPaid,
  });

  final FamilyGoal goal;
  final String memberName;
  final String creatorName;
  final int? currentPoints;
  final int? myId;
  final ShadThemeData shadTheme;
  final VoidCallback? onCancel;
  final VoidCallback? onMarkPaid;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final isCompleted = goal.status == FamilyGoalStatus.completed;
    final isCancelled = goal.status == FamilyGoalStatus.cancelled;
    final progress = currentPoints != null
        ? (currentPoints! / goal.targetPoints).clamp(0.0, 1.0)
        : null;

    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? shadTheme.colorScheme.primary.withValues(alpha: 0.15)
                      : isCancelled
                          ? shadTheme.colorScheme.muted
                          : shadTheme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    s.goalsRewardAmount(goal.rewardAmount),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: isCancelled
                          ? shadTheme.colorScheme.mutedForeground
                          : shadTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    Text(
                      '${s.goalsFor} $memberName',
                      style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground),
                    ),
                  ],
                ),
              ),
              if (isCompleted && goal.paidAt != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(s.goalsPaid, style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          if (goal.description != null && goal.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(goal.description!, style: TextStyle(fontSize: 13, color: shadTheme.colorScheme.mutedForeground)),
          ],
          const SizedBox(height: 12),
          // Points progress
          Row(
            children: [
              Icon(Icons.stars_outlined, size: 14, color: shadTheme.colorScheme.primary),
              const SizedBox(width: 4),
              Text(
                '${goal.targetPoints} pt',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: shadTheme.colorScheme.primary),
              ),
              if (currentPoints != null && goal.status == FamilyGoalStatus.active) ...[
                Text(
                  '  ·  ${s.goalsProgressOf} ${currentPoints!} pt attuali',
                  style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground),
                ),
              ],
              if (goal.deadline != null) ...[
                const Spacer(),
                Icon(Icons.calendar_today_outlined, size: 12, color: shadTheme.colorScheme.mutedForeground),
                const SizedBox(width: 4),
                Text(
                  '${goal.deadline!.day}/${goal.deadline!.month}/${goal.deadline!.year}',
                  style: TextStyle(fontSize: 11, color: shadTheme.colorScheme.mutedForeground),
                ),
              ],
            ],
          ),
          if (progress != null && goal.status == FamilyGoalStatus.active) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: shadTheme.colorScheme.muted,
                valueColor: AlwaysStoppedAnimation<Color>(shadTheme.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              progress >= 1.0
                  ? '✓ Obiettivo raggiunto!'
                  : s.goalsPointsNeeded(goal.targetPoints - currentPoints!),
              style: TextStyle(
                fontSize: 11,
                color: progress >= 1.0 ? Colors.green : shadTheme.colorScheme.mutedForeground,
              ),
            ),
          ],
          if (onMarkPaid != null || onCancel != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (onMarkPaid != null)
                  Expanded(
                    child: ShadButton(
                      onPressed: onMarkPaid,
                      child: Text(s.goalsMarkPaid, style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                if (onCancel != null)
                  Expanded(
                    child: ShadButton.ghost(
                      onPressed: onCancel,
                      child: Text(s.goalsCancel, style: const TextStyle(fontSize: 13, color: Colors.red)),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Create goal sheet ──────────────────────────────────────────────────────

class _CreateGoalSheet extends StatefulWidget {
  const _CreateGoalSheet({
    required this.members,
    required this.myUserId,
    required this.onSave,
  });

  final List<FamilyMemberInfo> members;
  final int? myUserId;
  final Future<void> Function(
    int targetUserId,
    String title,
    int targetPoints,
    double rewardAmount,
    String? description,
    DateTime? deadline,
  ) onSave;

  @override
  State<_CreateGoalSheet> createState() => _CreateGoalSheetState();
}

class _CreateGoalSheetState extends State<_CreateGoalSheet> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _pointsCtrl = TextEditingController(text: '100');
  final _rewardCtrl = TextEditingController(text: '5.00');
  int? _targetUserId;
  DateTime? _deadline;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.members.isNotEmpty) {
      _targetUserId = widget.members.first.userId;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _pointsCtrl.dispose();
    _rewardCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) return;
    if (_targetUserId == null) return;
    final pts = int.tryParse(_pointsCtrl.text.trim());
    final reward = double.tryParse(_rewardCtrl.text.trim().replaceAll(',', '.'));
    if (pts == null || pts <= 0 || reward == null || reward <= 0) return;

    setState(() => _saving = true);
    try {
      await widget.onSave(
        _targetUserId!,
        _titleCtrl.text.trim(),
        pts,
        reward,
        _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
        _deadline,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Errore: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final shadTheme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: shadTheme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).viewInsets.bottom + 32),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(color: shadTheme.colorScheme.border, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              Text(s.goalsCreateTitle, style: shadTheme.textTheme.h3),
              const SizedBox(height: 20),
              // Title
              ShadInput(
                controller: _titleCtrl,
                placeholder: const Text('Es. Raggiungi 200 punti questo mese'),
              ),
              const SizedBox(height: 12),
              // Description
              ShadInput(
                controller: _descCtrl,
                placeholder: Text(s.goalsDescriptionHint),
              ),
              const SizedBox(height: 12),
              // Target member
              Text(s.goalsFor, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              ShadSelect<int>(
                initialValue: _targetUserId,
                onChanged: (v) { if (v != null) setState(() => _targetUserId = v); },
                options: [
                  for (final m in widget.members)
                    ShadOption(value: m.userId, child: Text(m.userId == widget.myUserId ? '${m.displayName} (io)' : m.displayName)),
                ],
                selectedOptionBuilder: (ctx, v) {
                  final m = widget.members.where((m) => m.userId == v).firstOrNull;
                  return Text(m?.displayName ?? 'Seleziona...');
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.goalsTargetPoints, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 6),
                        ShadInput(controller: _pointsCtrl, keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.goalsReward, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 6),
                        ShadInput(controller: _rewardCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Deadline
              Text(s.goalsDeadlineOptional, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 6),
              ShadButton.outline(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 30)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _deadline = picked);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 16),
                    const SizedBox(width: 8),
                    Text(_deadline != null
                        ? '${_deadline!.day}/${_deadline!.month}/${_deadline!.year}'
                        : s.goalsDeadline),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ShadButton(
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text(s.goalsSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
