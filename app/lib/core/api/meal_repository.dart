import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class MealRepository {
  MealRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<Recipe> createRecipe(int familyId, String title) =>
      _client.meal.createRecipe(familyId, title);

  Future<List<Recipe>> listRecipes(int familyId) =>
      _client.meal.listRecipes(familyId);

  Future<MealPlan> savePlan(
    int familyId,
    DateTime weekStart,
    String mealsJson,
  ) =>
      _client.meal.saveMealPlan(familyId, weekStart, mealsJson);

  Future<MealPlan?> getPlan(int familyId, DateTime weekStart) =>
      _client.meal.getMealPlan(familyId, weekStart);

  Future<List<String>> shoppingFromPlan(
    int familyId,
    DateTime weekStart,
  ) =>
      _client.meal.shoppingItemsFromPlan(familyId, weekStart);

  Future<MealPlan> applyDietToPlan(
    int familyId,
    DateTime weekStart,
    int healthEntryId,
  ) =>
      _client.meal.applyDietToMealPlan(
        familyId,
        weekStart,
        healthEntryId,
      );

  String errorMessage(Object e) {
    if (e is FamyliaException) return e.message;
    return 'Errore: $e';
  }
}
