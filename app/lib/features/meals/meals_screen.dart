import 'dart:convert';

import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/api/meal_repository.dart';
import '../../core/extensions/context_extensions.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> with SingleTickerProviderStateMixin {
  final _repo = MealRepository();
  late final TabController _tabs;
  List<Recipe> _recipes = [];
  MealPlan? _plan;
  List<String> _shoppingItems = [];
  bool _loading = true;

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
      if (mounted) {
        setState(() {
          _recipes = recipes;
          _plan = plan;
          _shoppingItems = shop;
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
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Salva')),
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
    final weekLabel = DateFormat('d MMM yyyy').format(_weekStart);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal planner'),
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
        child: Icon(_tabs.index == 0 ? Icons.add : Icons.save),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabs,
              children: [
                ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (_, i) => ListTile(
                    leading: const Icon(Icons.restaurant_menu),
                    title: Text(_recipes[i].title),
                    subtitle: Text('${ _recipes[i].servings} porzioni'),
                  ),
                ),
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text('Settimana dal $weekLabel'),
                    const SizedBox(height: 12),
                    if (_plan == null)
                      const Text('Nessun piano — usa il pulsante salva per un esempio')
                    else
                      Text('Piano: ${_plan!.mealsJson}'),
                    const SizedBox(height: 24),
                    Text(
                      'Ingredienti per lista spesa',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (_shoppingItems.isEmpty)
                      const Text('Aggiungi pasti al piano')
                    else
                      for (final item in _shoppingItems)
                        ListTile(
                          dense: true,
                          leading: const Icon(Icons.shopping_basket_outlined, size: 20),
                          title: Text(item),
                        ),
                  ],
                ),
              ],
            ),
    );
  }
}
