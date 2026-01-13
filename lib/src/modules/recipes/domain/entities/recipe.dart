import 'package:flutter/material.dart';

/// Recipe entity
/// Represents a recipe with its details.
///
/// [id] - Unique identifier for the recipe **(auto-generated)**.
///
/// [icon] - Icon representing the recipe (in the future can be an image).
///
/// [title] - Title of the recipe.
///
/// [description] - Description of the recipe.
///
/// [ingredientsIds] - List of ingredient IDs required for the recipe.
///
/// Example:
/// ```dart
/// final recipe = Recipe(
///   id: '1',
///   icon: Icons.fastfood,
///   title: 'Pasta',
///   description: 'Delicious pasta recipe',
///   ingredientsIds: [
///     '1',
///     '2',
///   ],
/// );
/// ```
class Recipe {
  String? id;
  IconData? icon;
  String title;
  String description;
  final List<String> _ingredientsIds;

  Recipe({
    this.id,
    this.icon,
    this.title = '',
    this.description = '',
    List<String>? ingredientsIds,
  }) : _ingredientsIds = List<String>.from(ingredientsIds ?? const []);

  List<String> get ingredientsIds => List.unmodifiable(_ingredientsIds);

  void setIngredients(List<String> ids) {
    _ingredientsIds
      ..clear()
      ..addAll(ids);
  }

  void addIngredient(String ingredientId) {
    if (ingredientId.isEmpty || _ingredientsIds.contains(ingredientId)) {
      return;
    }
    _ingredientsIds.add(ingredientId);
  }

  void removeIngredient(String ingredientId) {
    _ingredientsIds.remove(ingredientId);
  }
}
