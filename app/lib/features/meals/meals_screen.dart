import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../core/api/health_repository.dart';
import '../../core/api/meal_repository.dart';
import '../../core/extensions/context_extensions.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({this.linkedDietId, super.key});

  final int? linkedDietId;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> with SingleTickerProviderStateMixin {
  final _repo = MealRepository();
  final _health = HealthRepository();
  late final TabController _tabs;
  List<Recipe> _recipes = [];
  MealPlan? _plan;
  List<String> _shoppingItems = [];
  HealthEntry? _linkedDiet;
  bool _loading = true;
  bool _linkingDiet = false;

  DateTime get _weekStart {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
  }

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    setState(() => _loading = true);
    try {
      final recipes = await _repo.listRecipes(familyId);
      final plan = await _repo.getPlan(familyId, _weekStart);
      final shop = await _repo.shoppingFromPlan(familyId, _weekStart);
      HealthEntry? diet;
      final dietId = widget.linkedDietId ?? plan?.linkedHealthEntryId;
      if (dietId != null) {
        final diets = await _health.list(
          familyId,
          type: HealthEntryType.diet,
        );
        diet = diets.where((d) => d.id == dietId).firstOrNull;
      }
      if (mounted) {
        setState(() {
          _recipes = recipes;
          _plan = plan;
          _shoppingItems = shop;
          _linkedDiet = diet;
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

  Future<void> _applyLinkedDiet() async {
    final familyId = context.activeFamilyId;
    final dietId = widget.linkedDietId ?? _linkedDiet?.id;
    if (familyId == null || dietId == null) return;
    setState(() => _linkingDiet = true);
    try {
      await _repo.applyDietToPlan(familyId, _weekStart, dietId);
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dieta collegata al piano settimanale')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _linkingDiet = false);
    }
  }

  Future<void> _addRecipe() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Nuova ricetta'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Nome'),
        ),
        actions: [
          ShadButton.ghost(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          ShadButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
        ],
      ),
    );
    if (ok != true || ctrl.text.trim().isEmpty) return;
    try {
      await _repo.createRecipe(familyId, ctrl.text);
      await _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_repo.errorMessage(e))),
        );
      }
    }
  }

  Future<void> _saveSamplePlan() async {
    final familyId = context.activeFamilyId;
    if (familyId == null) return;
    final meals = [
      {
        'day': 'lun',
        'meal': 'cena',
        'title': 'Pasta al pomodoro',
        'ingredients': ['pasta', 'pomodori', 'basilico'],
      },
      {
        'day': 'mar',
        'meal': 'cena',
        'title': 'Pollo e verdure',
        'ingredients': ['pollo', 'zucchine', 'patate'],
      },
    ];
    try {
      await _repo.savePlan(familyId, _weekStart, jsonEncode(meals));
      await _load();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Piano settimanale salvato')),
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
    final weekLabel = DateFormat('d MMM yyyy').format(_weekStart);
    final diet = _linkedDiet;
    final showDietBanner = diet != null;

    return Scaffold(
      backgroundColor: shadTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: shadTheme.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        title: const Text('Pasti'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Ricette'),
            Tab(text: 'Settimana'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tabs.index == 0 ? _addRecipe : _saveSamplePlan,
        backgroundColor: shadTheme.colorScheme.primary,
        foregroundColor: shadTheme.colorScheme.primaryForeground,
        child: Icon(_tabs.index == 0 ? Icons.add : Icons.save),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (showDietBanner)
                  Container(
                    width: double.infinity,
                    color: shadTheme.colorScheme.primary.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Dieta: ${diet.title}',
                          style: shadTheme.textTheme.p?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (diet.dietGoal != null)
                          Text(
                            diet.dietGoal!,
                            style: shadTheme.textTheme.muted,
                          ),
                        const SizedBox(height: 8),
                        ShadButton.outline(
                          onPressed: _linkingDiet ? null : _applyLinkedDiet,
                          child: _linkingDiet
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Collega al piano settimanale'),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: TabBarView(
                    controller: _tabs,
                    children: [
                      ListView.builder(
                        itemCount: _recipes.length,
                        itemBuilder: (_, i) => ListTile(
                          leading: const Icon(Icons.restaurant_menu),
                          title: Text(_recipes[i].title),
                          subtitle: Text('${_recipes[i].servings} porzioni'),
                        ),
                      ),
                      ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          Text('Settimana dal $weekLabel', style: shadTheme.textTheme.p),
                          const SizedBox(height: 12),
                          if (_plan == null)
                            Text(
                              'Nessun piano — collega una dieta o salva un esempio',
                              style: shadTheme.textTheme.muted,
                            )
                          else ...[
                            if (_plan!.linkedHealthEntryId != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  'Collegata a dieta #${_plan!.linkedHealthEntryId}',
                                  style: shadTheme.textTheme.small,
                                ),
                              ),
                            Text('Piano: ${_plan!.mealsJson}'),
                          ],
                          const SizedBox(height: 24),
                          Text(
                            'Ingredienti per lista spesa',
                            style: shadTheme.textTheme.p?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          if (_shoppingItems.isEmpty)
                            Text('Aggiungi pasti al piano', style: shadTheme.textTheme.muted)
                          else
                            for (final item in _shoppingItems)
                              ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.shopping_basket_outlined,
                                  size: 20,
                                ),
                                title: Text(item),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
