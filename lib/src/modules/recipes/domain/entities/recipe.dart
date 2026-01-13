import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

class Recipe {
  final String? id;
  final String? imagePath;
  final String name;
  final String description;
  final double yieldRecipe;
  final List<RecipeItem> items;

  Recipe({
    this.id,
    this.imagePath,
    this.name = '',
    this.description = '',
    this.yieldRecipe = 1.0,
    this.items = const [],
  });
}

class RecipeItem {
  final Ingredient ingredient;
  final double quantity;

  RecipeItem({required this.ingredient, required this.quantity});

  double get totalCost => ingredient.costPerUnit * quantity;
}
