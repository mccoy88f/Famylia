import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/location_repository.dart';
import '../../core/extensions/context_extensions.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _repo = LocationRepository();
  LocationSharing? _status;
  List<MemberLocation> _members = [];
  bool _loading = true;
  final _fmt = DateFormat('d/M HH:mm');

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
      final status = await _repo.getStatus(familyId);
      final members = await _repo.familyLocations(familyId);
      if (mounted) {
        setState(() {
          _status = status;
          _members = members;
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

  Future<void> _toggle(bool enabled) async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    try {
      final status = await _repo.updateStatus(familyId, enabled);
      if (mounted) setState(() => _status = status);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _checkIn() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    try {
      await _repo.checkIn(
        familyId,
        45.4642,
        9.1900,
        address: 'Check-in manuale',
      );
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Posizione condivisa')),
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
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Posizione'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SwitchListTile(
                    title: const Text('Condividi posizione'),
                    subtitle: const Text('Opt-in · auto-off dopo 24h'),
                    value: _status?.isEnabled ?? false,
                    onChanged: _toggle,
                  ),
                  if (_status?.expiresAt != null)
                    ListTile(
                      leading: const Icon(Icons.timer_outlined),
                      title: Text(
                        'Scade: ${_fmt.format(_status!.expiresAt!.toLocal())}',
                      ),
                    ),
                  const SizedBox(height: 8),
                  ShadButton(
                    onPressed: _checkIn,
                    width: double.infinity,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.my_location, size: 18),
                        SizedBox(width: 8),
                        Text('Check-in "Sono arrivato"'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Membri visibili',
                    style: shadTheme.textTheme.h4,
                  ),
                  const SizedBox(height: 8),
                  if (_members.isEmpty)
                    Text('Nessun membro con posizione condivisa', style: shadTheme.textTheme.muted)
                  else
                    for (final m in _members)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ShadCard(
                          child: ListTile(
                            leading: const Icon(Icons.person_pin_circle),
                            title: Text(m.displayName),
                            subtitle: Text(
                              '${m.address ?? '${m.latitude}, ${m.longitude}'}\n'
                              '${_fmt.format(m.recordedAt.toLocal())}',
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
    );
  }
}
