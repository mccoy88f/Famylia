import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/session/family_context.dart';
import 'maria_upsell_sheet.dart';

/// Sezione abbonamento MarIA da mostrare in AltroScreen.
class MarIASubscriptionSection extends StatefulWidget {
  const MarIASubscriptionSection({super.key});

  @override
  State<MarIASubscriptionSection> createState() => _MarIASubscriptionSectionState();
}

class _MarIASubscriptionSectionState extends State<MarIASubscriptionSection> {
  late TextEditingController _apiKeyCtrl;
  late TextEditingController _modelCtrl;
  bool _showConfig = false;

  @override
  void initState() {
    super.initState();
    final family = context.read<FamilyContext>();
    _apiKeyCtrl = TextEditingController(text: family.mariaApiKey);
    _modelCtrl = TextEditingController(text: family.mariaModel);
  }

  @override
  void dispose() {
    _apiKeyCtrl.dispose();
    _modelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    final shadTheme = ShadTheme.of(context);
    final family = context.watch<FamilyContext>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('MarIA Premium', style: shadTheme.textTheme.muted.copyWith(
            fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5,
          )),
        ),
        ShadCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Status row
              ListTile(
                leading: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: family.hasMarIA
                          ? [shadTheme.colorScheme.primary, shadTheme.colorScheme.primary.withValues(alpha: 0.7)]
                          : [shadTheme.colorScheme.muted, shadTheme.colorScheme.muted],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('M', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                title: Text(s.mariaName, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(
                  family.hasMarIA ? s.mariaPremiumActive : s.mariaPremiumSubtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: family.hasMarIA ? shadTheme.colorScheme.primary : shadTheme.colorScheme.mutedForeground,
                  ),
                ),
                trailing: family.hasMarIA
                    ? Icon(Icons.check_circle, color: shadTheme.colorScheme.primary)
                    : null,
              ),
              Divider(height: 1, color: shadTheme.colorScheme.border),
              if (!family.hasMarIA) ...[
                ListTile(
                  leading: Icon(Icons.rocket_launch_outlined, color: shadTheme.colorScheme.primary, size: 20),
                  title: Text(s.mariaPremiumActivate, style: TextStyle(color: shadTheme.colorScheme.primary, fontWeight: FontWeight.w600)),
                  trailing: Icon(Icons.chevron_right, size: 18, color: shadTheme.colorScheme.mutedForeground),
                  onTap: () => MarIAUpsellSheet.show(context),
                ),
              ] else ...[
                // Config toggle
                ListTile(
                  leading: Icon(Icons.settings_outlined, color: shadTheme.colorScheme.mutedForeground, size: 20),
                  title: Text(s.mariaPremiumManage),
                  trailing: Icon(
                    _showConfig ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 18,
                    color: shadTheme.colorScheme.mutedForeground,
                  ),
                  onTap: () => setState(() => _showConfig = !_showConfig),
                ),
                if (_showConfig) ...[
                  Divider(height: 1, color: shadTheme.colorScheme.border),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(s.mariaSettingsApiKey, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 6),
                        ShadInput(
                          controller: _apiKeyCtrl,
                          placeholder: Text(s.mariaSettingsApiKeyHint),
                          obscureText: true,
                        ),
                        const SizedBox(height: 12),
                        Text(s.mariaSettingsModel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 6),
                        ShadSelect<String>(
                          initialValue: _modelCtrl.text,
                          onChanged: (v) { if (v != null) _modelCtrl.text = v; },
                          options: const [
                            ShadOption(value: 'claude-sonnet-4-6', child: Text('Claude Sonnet 4.6 (consigliato)')),
                            ShadOption(value: 'claude-opus-4-8', child: Text('Claude Opus 4.8 (più potente)')),
                            ShadOption(value: 'claude-haiku-4-5-20251001', child: Text('Claude Haiku 4.5 (più veloce)')),
                          ],
                          selectedOptionBuilder: (ctx, v) => Text(v),
                        ),
                        const SizedBox(height: 16),
                        ShadButton(
                          width: double.infinity,
                          onPressed: () async {
                            await family.saveMarIAConfig(
                              apiKey: _apiKeyCtrl.text.trim(),
                              model: _modelCtrl.text,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(s.mariaSettingsSaved)),
                              );
                            }
                          },
                          child: Text(s.mariaSettingsSave),
                        ),
                        const SizedBox(height: 8),
                        ShadButton.destructive(
                          width: double.infinity,
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Disattiva MarIA?'),
                                content: const Text('Perderai accesso alle funzioni AI della famiglia.'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text('Disattiva', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) await family.deactivateMarIA();
                          },
                          child: const Text('Disattiva MarIA'),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Avatar di MarIA da mostrare nella lista membri quando Premium è attivo.
class MarIAMemberTile extends StatelessWidget {
  const MarIAMemberTile({super.key, required this.shadTheme});
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [shadTheme.colorScheme.primary, shadTheme.colorScheme.primary.withValues(alpha: 0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text('M', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(s.mariaName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: shadTheme.colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('AI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: shadTheme.colorScheme.primary)),
                    ),
                  ],
                ),
                Text(s.mariaRole, style: TextStyle(fontSize: 12, color: shadTheme.colorScheme.mutedForeground)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: shadTheme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Premium', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: shadTheme.colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
