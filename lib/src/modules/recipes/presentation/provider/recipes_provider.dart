import 'package:flutter/material.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository.dart';

class RecipesProvider with ChangeNotifier {
  final RecipesRepository repository;

  RecipesProvider(this.repository);

  List<Recipe> _recipes = [];

  List<Recipe> get all => _recipes;

  int get count => _recipes.length;

  Recipe? getById(String id) {
    try {
      return _recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
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
}
