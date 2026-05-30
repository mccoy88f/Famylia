import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/api/family_repository.dart';
import '../../core/theme/app_settings.dart';
import '../../core/session/family_context.dart';
import '../../core/theme/famylia_accent_presets.dart';

class FamilyAppearanceScreen extends StatefulWidget {
  const FamilyAppearanceScreen({super.key});

  @override
  State<FamilyAppearanceScreen> createState() => _FamilyAppearanceScreenState();
}

class _FamilyAppearanceScreenState extends State<FamilyAppearanceScreen> {
  final _families = FamilyRepository();
  String? _selectedHex;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedHex = context.read<FamilyContext>().accentColorHex;
  }

  Future<void> _saveAccent() async {
    final family = context.read<FamilyContext>();
    final id = family.activeFamilyId;
    final hex = _selectedHex;
    if (id == null || hex == null) return;
    if (!family.isAdmin) {
      setState(() => _error = 'Solo gli admin possono cambiare il colore famiglia.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final updated = await _families.updateAccentColor(id, hex);
      await family.setAccentColor(updated.accentColor ?? hex);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Colore famiglia aggiornato')),
        );
      }
    } catch (e) {
      setState(() => _error = _families.userFacingError(e));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final family = context.watch<FamilyContext>();
    final settings = context.watch<AppSettings>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Aspetto')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Tema',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text('Sistema'),
                icon: Icon(Icons.brightness_auto, size: 18),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text('Giorno'),
                icon: Icon(Icons.light_mode_outlined, size: 18),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text('Notte'),
                icon: Icon(Icons.dark_mode_outlined, size: 18),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (s) => settings.setThemeMode(s.first),
          ),
          const SizedBox(height: 32),
          Text(
            'Colore accento famiglia',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            family.isAdmin
                ? 'Visibile a tutti i membri di «${family.activeFamilyName ?? 'famiglia'}».'
                : 'Solo gli admin possono modificarlo.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurface.withValues(alpha: 0.65),
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final preset in FamyliaAccentPresets.presets)
                _AccentSwatch(
                  preset: preset,
                  selected: _selectedHex == preset.hex,
                  enabled: family.isAdmin,
                  onTap: () => setState(() => _selectedHex = preset.hex),
                ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!, style: TextStyle(color: scheme.error)),
          ],
          if (family.isAdmin) ...[
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving || _selectedHex == family.accentColorHex
                  ? null
                  : _saveAccent,
              child: _saving
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Salva colore famiglia'),
            ),
          ],
        ],
      ),
    );
  }
}

class _AccentSwatch extends StatelessWidget {
  const _AccentSwatch({
    required this.preset,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final AccentPreset preset;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: preset.label,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 72,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? preset.color
                  : Theme.of(context).colorScheme.outline.withValues(alpha: 0.4),
              width: selected ? 2.5 : 1,
            ),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: preset.color,
                child: selected
                    ? Icon(
                        Icons.check,
                        size: 18,
                        color: preset.color.computeLuminance() > 0.5
                            ? Colors.black87
                            : Colors.white,
                      )
                    : null,
              ),
              const SizedBox(height: 6),
              Text(
                preset.label,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
