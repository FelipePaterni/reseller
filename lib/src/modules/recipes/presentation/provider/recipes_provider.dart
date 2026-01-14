import 'package:flutter/material.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository.dart';

class RecipesProvider with ChangeNotifier {
  final RecipesRepository repository;

  RecipesProvider(this.repository);

  List<Recipe> _recipes = [];

  List<Recipe> get all => _recipes;

  int get count => _recipes.length;

  Recipe getById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      throw Exception('Recipe with id $id not found');
    }
  }

  Recipe getByIndex(int index) {
    if (index < 0 || index >= _recipes.length) {
      throw RangeError('Index out of range');
    }
    return _recipes[index];
  }

  Future<void> load() async {
    _recipes = await repository.getAll();
    notifyListeners();
  }

  Future<void> createOrUpdate(Recipe recipe) async {
    await repository.save(recipe);
    await load();
  }

  Future<void> deleteById(String id) async {
    await repository.delete(id);
    await load();
  }

  Future<void> deleteByObject(Recipe recipe) async {
    if (recipe.id == null || recipe.id!.isEmpty) return;
    await deleteById(recipe.id!);
  }

  /// Add a new recipe item to a recipe
  Future<void> addRecipeItem(String recipeId, RecipeItem item) async {
    final recipe = getById(recipeId);
    final updatedItems = [...recipe.items, item];
    final updatedRecipe = recipe.copyWith(items: updatedItems);
    await createOrUpdate(updatedRecipe);
  }

  /// Update an existing recipe item in a recipe
  Future<void> updateRecipeItem(
    String recipeId,
    int itemIndex,
    RecipeItem newItem,
  ) async {
    final recipe = getById(recipeId);
    final updatedItems = [...recipe.items];
    if (itemIndex >= 0 && itemIndex < updatedItems.length) {
      updatedItems[itemIndex] = newItem;
      final updatedRecipe = recipe.copyWith(items: updatedItems);
      await createOrUpdate(updatedRecipe);
    }
  }

  /// Remove a recipe item from a recipe
  Future<void> removeRecipeItem(String recipeId, int itemIndex) async {
    final recipe = getById(recipeId);
    final updatedItems = [...recipe.items];
    if (itemIndex >= 0 && itemIndex < updatedItems.length) {
      updatedItems.removeAt(itemIndex);
      final updatedRecipe = recipe.copyWith(items: updatedItems);
      await createOrUpdate(updatedRecipe);
    }
  }
}
