import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/domain/repositories/ingredients_repository.dart';

/// Provider for managing ingredients state
///
/// Delegates data operations to [IngredientsRepository] and manages UI state.
class IngredientsProvider with ChangeNotifier {
  final IngredientsRepository _repository;
  List<Ingredient> _ingredients = [];
  bool _isLoading = false;

  IngredientsProvider(this._repository) {
    _loadIngredients();
  }

  List<Ingredient> get getAll => [..._ingredients];

  int get count => _ingredients.length;

  bool get isLoading => _isLoading;

  Ingredient? getById(String id) {
    try {
      return _ingredients.firstWhere((i) => i.id == id);
    } catch (_) {
      return null;
    }
  }

  Ingredient getByIndex(int index) {
    if (index < 0 || index >= _ingredients.length) {
      throw RangeError('Index out of range');
    }
    return _ingredients[index];
  }

  /// Load all ingredients from repository
  Future<void> _loadIngredients() async {
    _isLoading = true;
    notifyListeners();

    try {
      _ingredients = await _repository.getAll();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Create or update an ingredient
  ///
  /// If the [ingredient] has an ID and exists, it updates it.
  /// Otherwise, it creates a new [ingredient] with a new ID.
  Future<void> createOrUpdate(Ingredient ingredient) async {
    await _repository.save(ingredient);
    await _loadIngredients();
  }

  /// Delete ingredient by ID
  Future<void> deleteById(String id) async {
    await _repository.delete(id);
    await _loadIngredients();
  }

  /// Delete ingredient by object
  Future<void> deleteByObject(Ingredient ingredient) async {
    if (ingredient.id != null && ingredient.id!.isNotEmpty) {
      await deleteById(ingredient.id!);
    }
  }
}
