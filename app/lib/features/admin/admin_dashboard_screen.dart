import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
  final _modelCtrl = TextEditingController();

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
    _modelCtrl.dispose();
    super.dispose();
  }

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
          _modelCtrl.text = config.modelName;
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
    final modelName = _modelCtrl.text.trim();
    if (provider == null || modelName.isEmpty) {
      setState(() => _configError = 'Seleziona provider e inserisci modello.');
      return;
    }
    setState(() {
      _savingConfig = true;
      _configError = null;
      _configSuccess = null;
    });
    try {
      final updated = await widget.repo.setAiConfig(provider, modelName);
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

  double get _totalCost =>
      _stats.fold(0.0, (sum, s) => sum + s.costUsd);
  int get _totalCalls => _stats.fold(0, (sum, s) => sum + s.calls);
  int get _totalInputTokens =>
      _stats.fold(0, (sum, s) => sum + s.inputTokens);
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
                            size: 16,
                            color: shadTheme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Configurazione AI', style: shadTheme.textTheme.h4),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_loadingConfig)
                      const Center(child: CircularProgressIndicator())
                    else ...[
                      Text(
                        'Provider',
                        style: shadTheme.textTheme.small
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6),
                      ShadSelect<String>(
                        initialValue: _selectedProvider ?? 'openrouter',
                        onChanged: (v) =>
                            setState(() => _selectedProvider = v),
                        placeholder: const Text('Seleziona provider'),
                        options: const [
                          ShadOption(
                              value: 'openrouter',
                              child: Text('OpenRouter')),
                          ShadOption(
                              value: 'gemini', child: Text('Google Gemini')),
                        ],
                        selectedOptionBuilder: (context, value) {
                          return Text(value == 'gemini'
                              ? 'Google Gemini'
                              : 'OpenRouter');
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nome modello',
                        style: shadTheme.textTheme.small
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 6),
                      ShadInput(
                        controller: _modelCtrl,
                        placeholder: const Text('es. google/gemini-flash-1.5'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Per OpenRouter usa il formato "provider/model-name"',
                        style:
                            shadTheme.textTheme.muted.copyWith(fontSize: 11),
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
                            : const Text('Salva'),
                      ),
                    ],
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
                            size: 16,
                            color: shadTheme.colorScheme.primary),
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
                          child: const Icon(Icons.refresh_outlined, size: 16),
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
                      // Header
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
                      // Rows
                      for (final stat in _stats)
                        _TableRow(
                          familyId: stat.familyId == 0
                              ? '(generico)'
                              : stat.familyId.toString(),
                          calls: stat.calls.toString(),
                          inputTokens: _fmt(stat.inputTokens),
                          outputTokens: _fmt(stat.outputTokens),
                          cost: '\$${stat.costUsd.toStringAsFixed(4)}',
                          isHeader: false,
                          shadTheme: shadTheme,
                        ),
                      const Divider(height: 1),
                      // Total
                      _TableRow(
                        familyId: 'TOTALE',
                        calls: _totalCalls.toString(),
                        inputTokens: _fmt(_totalInputTokens),
                        outputTokens: _fmt(_totalOutputTokens),
                        cost: '\$${_totalCost.toStringAsFixed(4)}',
                        isHeader: true,
                        shadTheme: shadTheme,
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
          Expanded(flex: 3, child: Text(familyId, style: style)),
          Expanded(flex: 2, child: Text(calls, style: style)),
          Expanded(flex: 2, child: Text(inputTokens, style: style)),
          Expanded(flex: 2, child: Text(outputTokens, style: style)),
          Expanded(flex: 2, child: Text(cost, style: style)),
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
