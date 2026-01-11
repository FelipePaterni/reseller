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
/// const recipe = Recipe(
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
interface class Recipe {
  final String? id;
  final IconData? icon;
  final String title;
  final String description;
  final List<String> ingredientsIds;

  const Recipe({
    this.id,
    this.icon,
    required this.title,
    required this.description,
    required this.ingredientsIds,
  });
}
