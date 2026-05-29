import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/api/auth_repository.dart';
import '../../core/api/gdpr_repository.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/router/app_router.dart';
import '../../core/session/family_context.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final _repo = GdprRepository();
  PrivacyDashboard? _dashboard;
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
      final dash = await _repo.privacyDashboard(familyId);
      if (mounted) setState(() => _dashboard = dash);
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

  Future<void> _export() async {
    try {
      final data = await _repo.exportMyData();
      await Clipboard.setData(ClipboardData(text: data.payloadJson));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export JSON copiato negli appunti')),
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

  Future<void> _deleteAccount() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Elimina account'),
        content: const Text(
          'Questa azione è irreversibile. I tuoi dati personali verranno rimossi.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.deleteMyAccount();
      if (!mounted) return;
      await context.read<FamilyContext>().clear();
      await AuthRepository().signOut();
      if (mounted) context.go(AppRoutes.login);
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
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy e GDPR')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Condivisione posizione'),
                    subtitle: Text(
                      _dashboard?.locationEnabled == true
                          ? 'Attiva · visibile a ${_dashboard!.sharedWithCount} membri'
                          : 'Disattivata',
                    ),
                  ),
                ),
                if (_dashboard?.viewersJson.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    child: Text('Visibile a: ${_dashboard!.viewersJson}'),
                  ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _export,
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Esporta i miei dati (GDPR)'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _deleteAccount,
                  icon: const Icon(Icons.delete_forever_outlined),
                  label: const Text('Elimina account'),
                ),
              ],
            ),
    );
  }
}
