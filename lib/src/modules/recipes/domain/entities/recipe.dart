import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

class Recipe {
  final String? id;
  final String imagePath;
  final String name;
  final double yieldRecipe;
  final List<RecipeItem> items;

  Recipe({
    this.id,
    this.imagePath = '',
    this.name = '',
    this.yieldRecipe = 1.0,
    this.items = const [],
  });

  Recipe copyWith({
    String? id,
    String? imagePath,
    String? name,
    double? yieldRecipe,
    List<RecipeItem>? items,
  }) {
    return Recipe(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      yieldRecipe: yieldRecipe ?? this.yieldRecipe,
      items: items ?? this.items,
    );
  }
}

class RecipeItem {
  final Ingredient ingredient;
  final double quantity;

  RecipeItem({required this.ingredient, required this.quantity});

  double get totalCost => ingredient.costPerUnit * quantity;

  RecipeItem copyWith({Ingredient? ingredient, double? quantity}) {
    return RecipeItem(
      ingredient: ingredient ?? this.ingredient,
      quantity: quantity ?? this.quantity,
    );
  }
}
