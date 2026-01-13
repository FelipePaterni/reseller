import 'package:flutter/material.dart';
import 'package:reseller/src/core/mocks/recipe_mock.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:uuid/uuid.dart';

/// Provider for managing recipes state
class RecipesProvider with ChangeNotifier {
  final Map<String, Recipe> _recipes = {...RECIPES_MOCK};

  List<Recipe> get getAll => [..._recipes.values];

  int get count => _recipes.length;

  Recipe? getById(String id) => _recipes[id];

  Recipe getByIndex(int index) {
    if (index < 0 || index >= _recipes.length) {
      throw RangeError('Index out of range');
    }
    return _recipes.values.elementAt(index);
  }

  /// Create or update a recipe
  ///
  /// If the [recipe] has an ID and exists, it updates it.
  /// Otherwise, it creates a new [recipe] with a new ID.
  void createOrUpdate(Recipe recipe) {
    if (recipe.id != null &&
        recipe.id!.isNotEmpty &&
        _recipes.containsKey(recipe.id)) {
      _recipes[recipe.id!] = recipe;
    } else {
      final id = Uuid().v4();

      _recipes[id] = Recipe(
        id: id,
        icon: recipe.icon,
        title: recipe.title,
        description: recipe.description,
        ingredientsIds: recipe.ingredientsIds,
      );
    }
    notifyListeners();
  }

  /// Delete recipe by ID
  void deleteById(String id) {
    if (_recipes.containsKey(id)) {
      _recipes.remove(id);
      notifyListeners();
    }
  }

  /// Delete recipe by object
  void deleteByObject(Recipe recipe) {
    if (recipe.id != null &&
        recipe.id!.isNotEmpty &&
        _recipes.containsKey(recipe.id)) {
      _recipes.remove(recipe.id);
      notifyListeners();
    }
  }
}
