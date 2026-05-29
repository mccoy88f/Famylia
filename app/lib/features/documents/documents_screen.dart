import 'package:famylia_client/famylia_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../core/api/document_repository.dart';
import '../../core/extensions/context_extensions.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final _repo = DocumentRepository();
  List<DocumentRecord> _docs = [];
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
      final docs = await _repo.list(familyId);
      if (mounted) setState(() => _docs = docs);
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

  Future<void> _upload() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final result = await FilePicker.platform.pickFiles(withData: true);
    if (!mounted) return;
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    final bytes = file.bytes;
    if (bytes == null) return;

    final titleCtrl = TextEditingController(text: file.name);
    if (!mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Carica documento'),
        content: TextField(
          controller: titleCtrl,
          decoration: const InputDecoration(labelText: 'Titolo'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Carica')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.upload(
        familyId,
        titleCtrl.text.trim().isEmpty ? file.name : titleCtrl.text,
        file.name,
        bytes,
      );
      await _load();
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
      appBar: AppBar(title: const Text('Documenti')),
      floatingActionButton: FloatingActionButton(
        onPressed: _upload,
        child: const Icon(Icons.upload_file),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView.builder(
                itemCount: _docs.length,
                itemBuilder: (_, i) {
                  final d = _docs[i];
                  return ListTile(
                    leading: const Icon(Icons.description_outlined),
                    title: Text(d.title),
                    subtitle: Text(d.fileUrl),
                    trailing: IconButton(
                      icon: const Icon(Icons.document_scanner_outlined),
                      tooltip: 'OCR',
                      onPressed: () async {
                        await _repo.runOcr(d.id!);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('OCR in coda')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
