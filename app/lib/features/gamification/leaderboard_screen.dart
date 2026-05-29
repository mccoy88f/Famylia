import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Classifica')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events),
                      title: const Text('I tuoi punti'),
                      trailing: Text(
                        '${_mine?.points ?? 0}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Leaderboard', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  if ((_board?.entries ?? []).isEmpty)
                    const Text('Completa task per guadagnare punti')
                  else
                    for (var i = 0; i < _board!.entries.length; i++)
                      ListTile(
                        leading: CircleAvatar(child: Text('${i + 1}')),
                        title: Text(_board!.entries[i].displayName),
                        trailing: Text('${_board!.entries[i].points} pt'),
                      ),
                ],
              ),
            ),
    );
  }
}
