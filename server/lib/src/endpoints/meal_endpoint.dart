import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/family_access.dart';

class MealEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Recipe> createRecipe(
    Session session,
    int familyId,
    String title, {
    String? description,
    String? ingredientsJson,
    int? servings,
  }) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      throw FamyliaException(message: 'Il titolo è obbligatorio.');
    }

    return Recipe.db.insertRow(
      session,
      Recipe(
        familyId: familyId,
        createdBy: userId,
        title: trimmed,
        description: description?.trim(),
        ingredientsJson: ingredientsJson ?? '[]',
        servings: servings ?? 4,
      ),
    );
  }

  Future<List<Recipe>> listRecipes(Session session, int familyId) async {
    await requireFamilyMember(session, familyId);
    return Recipe.db.find(
      session,
      where: (t) => t.familyId.equals(familyId),
      orderBy: (t) => t.title,
    );
  }

  Future<MealPlan> saveMealPlan(
    Session session,
    int familyId,
    DateTime weekStart,
    String mealsJson,
  ) async {
    await requireFamilyMemberNotGuest(session, familyId);
    final userId = await requireUserId(session);
    final week = DateTime.utc(weekStart.year, weekStart.month, weekStart.day);

    final existing = await MealPlan.db.findFirstRow(
      session,
      where: (t) => t.familyId.equals(familyId) & t.weekStart.equals(week),
    );
    if (existing != null) {
      return MealPlan.db.updateRow(
        session,
        existing.copyWith(mealsJson: mealsJson),
      );
    }

    return MealPlan.db.insertRow(
      session,
      MealPlan(
        familyId: familyId,
        createdBy: userId,
        weekStart: week,
        mealsJson: mealsJson,
      ),
    );
  }

  Future<MealPlan?> getMealPlan(
    Session session,
    int familyId,
    DateTime weekStart,
  ) async {
    await requireFamilyMember(session, familyId);
    final week = DateTime.utc(weekStart.year, weekStart.month, weekStart.day);
    return MealPlan.db.findFirstRow(
      session,
      where: (t) => t.familyId.equals(familyId) & t.weekStart.equals(week),
    );
  }

  /// Genera voci lista spesa dagli ingredienti del piano settimanale.
  Future<List<String>> shoppingItemsFromPlan(
    Session session,
    int familyId,
    DateTime weekStart,
  ) async {
    await requireFamilyMember(session, familyId);
    final plan = await getMealPlan(session, familyId, weekStart);
    if (plan == null) return [];

    final items = <String>{};
    final decoded = jsonDecode(plan.mealsJson);
    if (decoded is List) {
      for (final entry in decoded) {
        if (entry is Map && entry['ingredients'] is List) {
          for (final ing in entry['ingredients'] as List) {
            final name = ing is String ? ing : ing.toString();
            if (name.trim().isNotEmpty) items.add(name.trim());
          }
        }
      }
    }
    return items.toList()..sort();
  }
}
