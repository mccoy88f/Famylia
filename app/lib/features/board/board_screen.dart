import 'dart:async';
import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/board_repository.dart';
import '../../core/extensions/context_extensions.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final _repo = BoardRepository();
  List<BoardPostWithPoll> _posts = [];
  StreamSubscription<List<BoardPostWithPoll>>? _sub;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startWatch());
  }

  void _startWatch() {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    _sub?.cancel();
    _sub = _repo.watch(familyId).listen(
      (posts) {
        if (mounted) {
          setState(() {
            _posts = posts;
            _loading = false;
          });
        }
      },
      onError: (e) {
        if (mounted) {
          setState(() => _loading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_repo.errorMessage(e))),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _addNote() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo post'),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Scrivi un messaggio...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Pubblica')),
        ],
      ),
    );
    if (ok != true || ctrl.text.trim().isEmpty) return;
    try {
      await _repo.createNote(familyId, ctrl.text);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _addPoll() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final qCtrl = TextEditingController();
    final opt1 = TextEditingController();
    final opt2 = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuovo sondaggio'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: qCtrl, decoration: const InputDecoration(labelText: 'Domanda')),
            TextField(controller: opt1, decoration: const InputDecoration(labelText: 'Opzione 1')),
            TextField(controller: opt2, decoration: const InputDecoration(labelText: 'Opzione 2')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Crea')),
        ],
      ),
    );
    if (ok != true || qCtrl.text.trim().isEmpty) return;
    try {
      await _repo.createPoll(
        familyId,
        qCtrl.text,
        [opt1.text, opt2.text].where((s) => s.trim().isNotEmpty).toList(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  int _voteCount(PollOption o) {
    try {
      final list = jsonDecode(o.votesJson) as List;
      return list.length;
    } catch (_) {
      return 0;
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
        title: const Text('Bacheca'),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'poll',
            onPressed: _addPoll,
            backgroundColor: shadTheme.colorScheme.primary,
            foregroundColor: shadTheme.colorScheme.primaryForeground,
            child: const Icon(Icons.poll),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'note',
            onPressed: _addNote,
            backgroundColor: shadTheme.colorScheme.primary,
            foregroundColor: shadTheme.colorScheme.primaryForeground,
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _posts.isEmpty
              ? const Center(child: Text('Nessun post'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _posts.length,
                  itemBuilder: (_, i) {
                    final item = _posts[i];
                    final post = item.post;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ShadCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (post.isPinned)
                              ShadBadge.raw(
                                variant: ShadBadgeVariant.secondary,
                                child: const Text('In evidenza'),
                              ),
                            if (post.isPinned) const SizedBox(height: 6),
                            Text(
                              post.content,
                              style: shadTheme.textTheme.p?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            if (post.type == BoardPostType.poll) ...[
                              const SizedBox(height: 8),
                              for (final opt in item.options)
                                ListTile(
                                  dense: true,
                                  title: Text(opt.text),
                                  trailing: Text('${_voteCount(opt)} voti'),
                                  onTap: () async {
                                    await _repo.vote(opt.id!);
                                  },
                                ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
