import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/gamification_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/l10n/app_localizations.dart';
import 'goals_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final _repo = GamificationRepository();
  UserPoints? _mine;
  Leaderboard? _board;
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
      final mine = await _repo.myPoints(familyId);
      final board = await _repo.leaderboard(familyId);
      if (mounted) {
        setState(() {
          _mine = mine;
          _board = board;
        });
      }
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
    final shadTheme = ShadTheme.of(context);
    final s = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text(s.leaderboardTitle.split('?').first.trim()),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ShadButton.ghost(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GoalsScreen()),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(s.goalsTitle, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
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
                  ShadCard(
                    backgroundColor: shadTheme.colorScheme.primary.withValues(alpha: 0.1),
                    child: ListTile(
                      leading: Icon(Icons.stars, color: shadTheme.colorScheme.primary),
                      title: Text(s.leaderboardMyPoints),
                      trailing: Text(
                        '${_mine?.points ?? 0}',
                        style: shadTheme.textTheme.h2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(s.leaderboardTitle, style: shadTheme.textTheme.h4),
                  const SizedBox(height: 8),
                  if ((_board?.entries ?? []).isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(s.leaderboardEmpty, style: shadTheme.textTheme.muted, textAlign: TextAlign.center),
                    )
                  else
                    for (var i = 0; i < _board!.entries.length; i++) ...[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: i == 0
                              ? const Color(0xFFFFD700)
                              : i == 1
                                  ? const Color(0xFFC0C0C0)
                                  : i == 2
                                      ? const Color(0xFFCD7F32)
                                      : shadTheme.colorScheme.muted,
                          child: Text(
                            i < 3 ? ['🥇', '🥈', '🥉'][i] : '${i + 1}',
                            style: TextStyle(fontSize: i < 3 ? 18.0 : 14.0),
                          ),
                        ),
                        title: Text(_board!.entries[i].displayName, style: const TextStyle(fontWeight: FontWeight.w600)),
                        trailing: Text('${_board!.entries[i].points} pt',
                            style: TextStyle(color: shadTheme.colorScheme.primary, fontWeight: FontWeight.w700)),
                      ),
                      if (i < _board!.entries.length - 1)
                        Divider(height: 1, indent: 56, color: shadTheme.colorScheme.border),
                    ],
                ],
              ),
            ),
    );
  }
}
