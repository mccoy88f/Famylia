import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/ai/ai_model_catalog.dart';
import '../../core/api/admin_repository.dart';

class AdminDashboardScreen extends StatefulWidget {
  final AdminRepository repo;

  const AdminDashboardScreen({super.key, required this.repo});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Config section
  AiConfig? _config;
  bool _loadingConfig = true;
  bool _savingConfig = false;
  String? _configError;
  String? _configSuccess;
  String? _selectedProvider;
  String? _selectedModelId;
  bool _visionFilter = false; // false=text-only, true=text+image

  // Prompt section
  final _promptCtrl = TextEditingController();
  bool _savingPrompt = false;
  String? _promptError;
  String? _promptSuccess;

  // Quota section
  final _quotaFamilyIdCtrl = TextEditingController();
  bool _loadingQuota = false;
  bool _savingQuota = false;
  FamilyQuota? _loadedQuota;
  String? _quotaError;
  String? _quotaSuccess;
  final _tokenLimitCtrl = TextEditingController();
  final _costLimitCtrl = TextEditingController();

  // Usage section
  List<UsageStat> _stats = [];
  bool _loadingStats = true;
  String? _statsError;

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _loadStats();
  }

  @override
  void dispose() {
    _promptCtrl.dispose();
    _quotaFamilyIdCtrl.dispose();
    _tokenLimitCtrl.dispose();
    _costLimitCtrl.dispose();
    super.dispose();
  }

  List<AiModelInfo> get _filteredModels => AiModelCatalog.models
      .where((m) => m.supportsVision == _visionFilter)
      .toList();

  Future<void> _loadConfig() async {
    setState(() {
      _loadingConfig = true;
      _configError = null;
    });
    try {
      final config = await widget.repo.getAiConfig();
      if (mounted) {
        setState(() {
          _config = config;
          _selectedProvider = config.provider.name;
          _selectedModelId = config.modelName;
          // determine vision filter from current model
          final info = AiModelCatalog.findById(config.modelName);
          _visionFilter = info?.supportsVision ?? false;
          _promptCtrl.text = config.systemPrompt;
          _loadingConfig = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingConfig = false;
          _configError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  Future<void> _saveConfig() async {
    final provider = _selectedProvider;
    final modelId = _selectedModelId;
    if (provider == null || modelId == null) {
      setState(() => _configError = 'Seleziona provider e modello.');
      return;
    }
    setState(() {
      _savingConfig = true;
      _configError = null;
      _configSuccess = null;
    });
    try {
      final updated =
          await widget.repo.setAiConfig(provider, modelId);
      if (mounted) {
        setState(() {
          _config = updated;
          _savingConfig = false;
          _configSuccess = 'Configurazione salvata.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _savingConfig = false;
          _configError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  Future<void> _savePrompt() async {
    final prompt = _promptCtrl.text.trim();
    if (prompt.isEmpty) {
      setState(() => _promptError = 'Il prompt non può essere vuoto.');
      return;
    }
    final provider = _selectedProvider ?? _config?.provider.name ?? 'openrouter';
    final modelId = _selectedModelId ?? _config?.modelName ?? '';
    setState(() {
      _savingPrompt = true;
      _promptError = null;
      _promptSuccess = null;
    });
    try {
      final updated =
          await widget.repo.setAiConfig(provider, modelId, systemPrompt: prompt);
      if (mounted) {
        setState(() {
          _config = updated;
          _savingPrompt = false;
          _promptSuccess = 'Prompt salvato.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _savingPrompt = false;
          _promptError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  Future<void> _loadQuota() async {
    final idText = _quotaFamilyIdCtrl.text.trim();
    final familyId = int.tryParse(idText);
    if (familyId == null) {
      setState(() => _quotaError = 'ID famiglia non valido.');
      return;
    }
    setState(() {
      _loadingQuota = true;
      _quotaError = null;
      _quotaSuccess = null;
    });
    try {
      final quota = await widget.repo.getFamilyQuota(familyId);
      if (mounted) {
        setState(() {
          _loadedQuota = quota;
          _tokenLimitCtrl.text = quota?.monthlyTokenLimit?.toString() ?? '';
          _costLimitCtrl.text = quota?.monthlyCostLimitUsd?.toString() ?? '';
          _loadingQuota = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingQuota = false;
          _quotaError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  Future<void> _saveQuota() async {
    final idText = _quotaFamilyIdCtrl.text.trim();
    final familyId = int.tryParse(idText);
    if (familyId == null) {
      setState(() => _quotaError = 'ID famiglia non valido.');
      return;
    }
    final tokenLimit = _tokenLimitCtrl.text.trim().isEmpty
        ? null
        : int.tryParse(_tokenLimitCtrl.text.trim());
    final costLimit = _costLimitCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_costLimitCtrl.text.trim());
    setState(() {
      _savingQuota = true;
      _quotaError = null;
      _quotaSuccess = null;
    });
    try {
      final updated = await widget.repo.setFamilyQuota(familyId,
          monthlyTokenLimit: tokenLimit, monthlyCostLimitUsd: costLimit);
      if (mounted) {
        setState(() {
          _loadedQuota = updated;
          _savingQuota = false;
          _quotaSuccess = 'Limiti salvati.';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _savingQuota = false;
          _quotaError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  Future<void> _loadStats() async {
    setState(() {
      _loadingStats = true;
      _statsError = null;
    });
    try {
      final stats = await widget.repo.getUsageStats();
      if (mounted) {
        setState(() {
          _stats = stats;
          _loadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingStats = false;
          _statsError = widget.repo.errorMessage(e);
        });
      }
    }
  }

  double get _totalCost => _stats.fold(0.0, (sum, s) => sum + s.costUsd);
  int get _totalCalls => _stats.fold(0, (sum, s) => sum + s.calls);
  int get _totalInputTokens => _stats.fold(0, (sum, s) => sum + s.inputTokens);
  int get _totalOutputTokens =>
      _stats.fold(0, (sum, s) => sum + s.outputTokens);

  @override
  Widget build(BuildContext context) {
    final shadTheme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: Text('MarIA Admin', style: shadTheme.textTheme.h4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Config Section ──────────────────────────────────────────
              ShadCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tune_outlined,
                            size: 16, color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Configurazione AI',
                            style: shadTheme.textTheme.h4, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_loadingConfig)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      // Vision filter toggle
                      Row(
                        children: [
                          Expanded(
                            child: _ToggleButton(
                              label: 'Solo testo',
                              selected: !_visionFilter,
                              onTap: () =>
                                  setState(() => _visionFilter = false),
                              shadTheme: shadTheme,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ToggleButton(
                              label: 'Testo + Immagini',
                              selected: _visionFilter,
                              onTap: () => setState(() => _visionFilter = true),
                              shadTheme: shadTheme,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Model list
                      _ModelPicker(
                        models: _filteredModels,
                        selectedId: _selectedModelId,
                        onSelect: (model) {
                          setState(() {
                            _selectedModelId = model.id;
                            _selectedProvider = model.provider;
                          });
                        },
                        shadTheme: shadTheme,
                      ),
                      if (_configError != null) ...[
                        const SizedBox(height: 12),
                        _ErrorCard(
                            message: _configError!, shadTheme: shadTheme),
                      ],
                      if (_configSuccess != null) ...[
                        const SizedBox(height: 12),
                        _SuccessCard(
                            message: _configSuccess!, shadTheme: shadTheme),
                      ],
                      const SizedBox(height: 16),
                      ShadButton(
                        onPressed: _savingConfig ? null : _saveConfig,
                        width: double.infinity,
                        child: _savingConfig
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Text('Salva modello'),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Prompt AI Section ─────────────────────────────────────────
              ShadCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.edit_note_outlined,
                            size: 16, color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Prompt AI', style: shadTheme.textTheme.h4, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Istruzione inviata a MarIA per ogni richiesta',
                      style: shadTheme.textTheme.muted,
                    ),
                    const SizedBox(height: 12),
                    if (_loadingConfig)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      ShadInput(
                        controller: _promptCtrl,
                        minLines: 4,
                        maxLines: 8,
                        placeholder:
                            const Text('Inserisci il system prompt...'),
                      ),
                      if (_promptError != null) ...[
                        const SizedBox(height: 12),
                        _ErrorCard(
                            message: _promptError!, shadTheme: shadTheme),
                      ],
                      if (_promptSuccess != null) ...[
                        const SizedBox(height: 12),
                        _SuccessCard(
                            message: _promptSuccess!, shadTheme: shadTheme),
                      ],
                      const SizedBox(height: 16),
                      ShadButton(
                        onPressed: _savingPrompt ? null : _savePrompt,
                        width: double.infinity,
                        child: _savingPrompt
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              )
                            : const Text('Salva prompt'),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Limiti per famiglia ────────────────────────────────────────
              ShadCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.manage_accounts_outlined,
                            size: 16, color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(child: Text('Limiti per famiglia',
                            style: shadTheme.textTheme.h4, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ShadInput(
                            controller: _quotaFamilyIdCtrl,
                            placeholder: const Text('ID famiglia'),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ShadButton.outline(
                          onPressed: _loadingQuota ? null : _loadQuota,
                          child: _loadingQuota
                              ? const SizedBox(
                                  height: 14,
                                  width: 14,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Text('Carica'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Limite token mensili',
                      style: shadTheme.textTheme.small
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    ShadInput(
                      controller: _tokenLimitCtrl,
                      placeholder: const Text('illimitato'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Limite spesa mensile (\$)',
                      style: shadTheme.textTheme.small
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 6),
                    ShadInput(
                      controller: _costLimitCtrl,
                      placeholder: const Text('illimitato'),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                    if (_quotaError != null) ...[
                      const SizedBox(height: 12),
                      _ErrorCard(message: _quotaError!, shadTheme: shadTheme),
                    ],
                    if (_quotaSuccess != null) ...[
                      const SizedBox(height: 12),
                      _SuccessCard(
                          message: _quotaSuccess!, shadTheme: shadTheme),
                    ],
                    const SizedBox(height: 16),
                    ShadButton(
                      onPressed: _savingQuota ? null : _saveQuota,
                      width: double.infinity,
                      child: _savingQuota
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Salva limiti'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Usage Section ────────────────────────────────────────────
              ShadCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart_outlined,
                            size: 16, color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Utilizzo token (ultimi 30 giorni)',
                            style: shadTheme.textTheme.h4,
                          ),
                        ),
                        ShadButton.ghost(
                          size: ShadButtonSize.sm,
                          onPressed: _loadingStats ? null : _loadStats,
                          child:
                              const Icon(Icons.refresh_outlined, size: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_loadingStats)
                      const Center(child: CircularProgressIndicator())
                    else if (_statsError != null)
                      _ErrorCard(
                          message: _statsError!, shadTheme: shadTheme)
                    else if (_stats.isEmpty)
                      Text(
                        'Nessun dato disponibile.',
                        style: shadTheme.textTheme.muted,
                      )
                    else ...[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TableRow(
                              familyId: 'Famiglia ID',
                              calls: 'Chiamate',
                              inputTokens: 'Token in',
                              outputTokens: 'Token out',
                              cost: 'Costo \$',
                              isHeader: true,
                              shadTheme: shadTheme,
                            ),
                            const Divider(height: 1),
                            for (final stat in _stats)
                              _TableRow(
                                familyId: stat.familyId == 0
                                    ? '(generico)'
                                    : stat.familyId.toString(),
                                calls: stat.calls.toString(),
                                inputTokens: _fmt(stat.inputTokens),
                                outputTokens: _fmt(stat.outputTokens),
                                cost:
                                    '\$${stat.costUsd.toStringAsFixed(4)}',
                                isHeader: false,
                                shadTheme: shadTheme,
                              ),
                            const Divider(height: 1),
                            _TableRow(
                              familyId: 'TOTALE',
                              calls: _totalCalls.toString(),
                              inputTokens: _fmt(_totalInputTokens),
                              outputTokens: _fmt(_totalOutputTokens),
                              cost:
                                  '\$${_totalCost.toStringAsFixed(4)}',
                              isHeader: true,
                              shadTheme: shadTheme,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.shadTheme,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? shadTheme.colorScheme.primary
              : shadTheme.colorScheme.muted,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? shadTheme.colorScheme.primaryForeground
                : shadTheme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _ModelPicker extends StatelessWidget {
  const _ModelPicker({
    required this.models,
    required this.selectedId,
    required this.onSelect,
    required this.shadTheme,
  });
  final List<AiModelInfo> models;
  final String? selectedId;
  final void Function(AiModelInfo) onSelect;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final freeModels = models.where((m) => m.isFree).toList();
    final paidModels = models.where((m) => !m.isFree).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (freeModels.isNotEmpty) ...[
          Text('Gratuiti',
              style: shadTheme.textTheme.small
                  .copyWith(fontWeight: FontWeight.w600, color: shadTheme.colorScheme.mutedForeground)),
          const SizedBox(height: 4),
          for (final m in freeModels) _ModelTile(model: m, selectedId: selectedId, onSelect: onSelect, shadTheme: shadTheme),
          const SizedBox(height: 8),
        ],
        if (paidModels.isNotEmpty) ...[
          Text('A pagamento',
              style: shadTheme.textTheme.small
                  .copyWith(fontWeight: FontWeight.w600, color: shadTheme.colorScheme.mutedForeground)),
          const SizedBox(height: 4),
          for (final m in paidModels) _ModelTile(model: m, selectedId: selectedId, onSelect: onSelect, shadTheme: shadTheme),
        ],
      ],
    );
  }
}

class _ModelTile extends StatelessWidget {
  const _ModelTile({
    required this.model,
    required this.selectedId,
    required this.onSelect,
    required this.shadTheme,
  });
  final AiModelInfo model;
  final String? selectedId;
  final void Function(AiModelInfo) onSelect;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final isSelected = model.id == selectedId;
    String priceLabel;
    if (model.isFree && model.inputPricePerM == 0) {
      priceLabel = 'Gratuito';
    } else {
      priceLabel =
          '\$${model.inputPricePerM.toStringAsFixed(3)}/M in • \$${model.outputPricePerM.toStringAsFixed(2)}/M out';
    }
    return GestureDetector(
      onTap: () => onSelect(model),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? shadTheme.colorScheme.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? shadTheme.colorScheme.primary
                : shadTheme.colorScheme.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.displayName,
                      style: shadTheme.textTheme.small
                          .copyWith(fontWeight: FontWeight.w500)),
                  Text(priceLabel,
                      style: shadTheme.textTheme.muted
                          .copyWith(fontSize: 11)),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check, size: 16, color: shadTheme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.familyId,
    required this.calls,
    required this.inputTokens,
    required this.outputTokens,
    required this.cost,
    required this.isHeader,
    required this.shadTheme,
  });

  final String familyId;
  final String calls;
  final String inputTokens;
  final String outputTokens;
  final String cost;
  final bool isHeader;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    final style = isHeader
        ? shadTheme.textTheme.small.copyWith(fontWeight: FontWeight.w600)
        : shadTheme.textTheme.small;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(familyId, style: style)),
          SizedBox(width: 80, child: Text(calls, style: style)),
          SizedBox(width: 90, child: Text(inputTokens, style: style)),
          SizedBox(width: 90, child: Text(outputTokens, style: style)),
          SizedBox(width: 90, child: Text(cost, style: style)),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.shadTheme});
  final String message;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(12),
      backgroundColor:
          shadTheme.colorScheme.destructive.withValues(alpha: 0.08),
      child: Row(
        children: [
          Icon(Icons.error_outline,
              size: 16, color: shadTheme.colorScheme.destructive),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                  color: shadTheme.colorScheme.destructive, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard({required this.message, required this.shadTheme});
  final String message;
  final ShadThemeData shadTheme;

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF10B981);
    return ShadCard(
      padding: const EdgeInsets.all(12),
      backgroundColor: green.withValues(alpha: 0.08),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 16, color: green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message,
                style: const TextStyle(color: green, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
