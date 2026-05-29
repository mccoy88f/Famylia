import 'dart:async';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';

import '../../core/api/emergency_repository.dart';
import '../../core/extensions/context_extensions.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _repo = EmergencyRepository();
  List<EmergencyAlert> _alerts = [];
  List<EmergencyContact> _contacts = [];
  EmergencySettings? _settings;
  StreamSubscription<List<EmergencyAlert>>? _sub;
  int? _countdown;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadContacts();
      _watch();
    });
  }

  void _watch() {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    _sub?.cancel();
    _sub = _repo.watch(familyId).listen(
      (alerts) {
        if (mounted) setState(() => _alerts = alerts);
      },
      onError: (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_repo.errorMessage(e))),
          );
        }
      },
    );
  }

  Future<void> _loadContacts() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    try {
      final settings = await _repo.settings(familyId);
      final contacts = await _repo.contacts(familyId);
      if (mounted) {
        setState(() {
          _settings = settings;
          _contacts = contacts;
        });
      }
    } catch (_) {}
  }

  void _startPanic({required bool isTest}) {
    final seconds = _settings?.confirmationSeconds ?? 3;
    setState(() => _countdown = seconds);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_countdown == null || _countdown! <= 1) {
        t.cancel();
        setState(() => _countdown = null);
        _sendAlert(isTest: isTest);
      } else {
        setState(() => _countdown = _countdown! - 1);
      }
    });
  }

  void _cancelCountdown() {
    _timer?.cancel();
    setState(() => _countdown = null);
  }

  Future<void> _sendAlert({required bool isTest}) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    try {
      await _repo.trigger(
        familyId,
        EmergencyAlertType.other,
        message: isTest ? 'Test emergenza' : 'Ho bisogno di aiuto',
        isTest: isTest,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isTest ? 'Test inviato' : 'Allerta inviata alla famiglia'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergenza')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 48),
                  const SizedBox(height: 8),
                  Text(
                    'Famylia non sostituisce il 112',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'In caso di pericolo immediato chiama i servizi di emergenza.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_countdown != null)
            Column(
              children: [
                Text('Invio tra $_countdown...', style: Theme.of(context).textTheme.headlineMedium),
                TextButton(onPressed: _cancelCountdown, child: const Text('Annulla')),
              ],
            )
          else ...[
            SizedBox(
              width: double.infinity,
              height: 120,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _startPanic(isTest: false),
                child: const Text('PANIC', style: TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _startPanic(isTest: true),
              icon: const Icon(Icons.science_outlined),
              label: const Text('Modalità test'),
            ),
          ],
          const SizedBox(height: 24),
          Text('Allerte attive', style: Theme.of(context).textTheme.titleMedium),
          if (_alerts.isEmpty)
            const ListTile(title: Text('Nessuna allerta attiva'))
          else
            for (final a in _alerts)
              Card(
                child: ListTile(
                  title: Text(a.isTest ? 'TEST · ${a.alertType.name}' : a.alertType.name),
                  subtitle: Text(a.customMessage ?? ''),
                  trailing: PopupMenuButton<String>(
                    onSelected: (v) async {
                      if (a.id == null) return;
                      if (v == 'ack') await _repo.acknowledge(a.id!);
                      if (v == 'resolve') await _repo.resolve(a.id!);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: 'ack', child: Text('Visto')),
                      PopupMenuItem(value: 'resolve', child: Text('Risolto')),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 16),
          Text('Contatti emergenza', style: Theme.of(context).textTheme.titleMedium),
          for (final c in _contacts)
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: Text(c.name),
              subtitle: Text(c.phone),
            ),
        ],
      ),
    );
  }
}
