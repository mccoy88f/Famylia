import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/gamification_repository.dart';
import '../../core/extensions/context_extensions.dart';

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
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Classifica'),
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
                      leading: Icon(Icons.emoji_events, color: shadTheme.colorScheme.primary),
                      title: const Text('I tuoi punti'),
                      trailing: Text(
                        '${_mine?.points ?? 0}',
                        style: shadTheme.textTheme.h2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Leaderboard', style: shadTheme.textTheme.h4),
                  const SizedBox(height: 8),
                  if ((_board?.entries ?? []).isEmpty)
                    Text('Completa task per guadagnare punti', style: shadTheme.textTheme.muted)
                  else
                    for (var i = 0; i < _board!.entries.length; i++)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: shadTheme.colorScheme.primary,
                          foregroundColor: shadTheme.colorScheme.primaryForeground,
                          child: Text('${i + 1}'),
                        ),
                        title: Text(_board!.entries[i].displayName),
                        trailing: Text('${_board!.entries[i].points} pt'),
                      ),
                ],
              ),
            ),
    );
  }
}
