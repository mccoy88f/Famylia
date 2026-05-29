import 'package:famylia_client/famylia_client.dart';
import 'package:flutter/material.dart';

class ShoppingCategoryStyle {
  const ShoppingCategoryStyle(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;

  static ShoppingCategoryStyle forCategory(ShoppingCategory category) {
    return switch (category) {
      ShoppingCategory.dairy => const ShoppingCategoryStyle(
          'Latticini',
          Icons.egg_outlined,
          Color(0xFF5C9CE6),
        ),
      ShoppingCategory.meat => const ShoppingCategoryStyle(
          'Carne',
          Icons.set_meal_outlined,
          Color(0xFFE57373),
        ),
      ShoppingCategory.vegetables => const ShoppingCategoryStyle(
          'Verdura',
          Icons.eco_outlined,
          Color(0xFF66BB6A),
        ),
      ShoppingCategory.fruit => const ShoppingCategoryStyle(
          'Frutta',
          Icons.apple_outlined,
          Color(0xFFFFB74D),
        ),
      ShoppingCategory.bakery => const ShoppingCategoryStyle(
          'Panetteria',
          Icons.bakery_dining_outlined,
          Color(0xFF8D6E63),
        ),
      ShoppingCategory.beverages => const ShoppingCategoryStyle(
          'Bevande',
          Icons.local_drink_outlined,
          Color(0xFF4DD0E1),
        ),
      ShoppingCategory.frozen => const ShoppingCategoryStyle(
          'Surgelati',
          Icons.ac_unit_outlined,
          Color(0xFF90CAF9),
        ),
      ShoppingCategory.household => const ShoppingCategoryStyle(
          'Casa',
          Icons.home_outlined,
          Color(0xFF9575CD),
        ),
      ShoppingCategory.personal => const ShoppingCategoryStyle(
          'Personale',
          Icons.person_outline,
          Color(0xFFF06292),
        ),
      ShoppingCategory.other => const ShoppingCategoryStyle(
          'Altro',
          Icons.shopping_bag_outlined,
          Color(0xFF9E9E9E),
        ),
    };
  }
}
