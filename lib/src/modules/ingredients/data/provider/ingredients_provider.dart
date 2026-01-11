import 'dart:math';
import 'package:flutter/material.dart';
import 'package:reseller/src/core/mocks/ingredients_mock.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

/// Provider for managing ingredients state
class IngredientsProvider with ChangeNotifier {
  final Map<String, Ingredient> _ingredients = {...INGREDIENTS_MOCK};

  List<Ingredient> get getAll => [..._ingredients.values];

  int get count => _ingredients.length;

  Ingredient? getById(String id) => _ingredients[id];

  Ingredient getByIndex(int index) => _ingredients.values.elementAt(index);

  /// Update existing ingredient or create new one
  void update(Ingredient ingredient) {
    if (ingredient.id != null &&
        ingredient.id!.isNotEmpty &&
        _ingredients.containsKey(ingredient.id)) {
      _ingredients[ingredient.id!] = ingredient;
      notifyListeners();
    } else {
      create(ingredient);
    }
  }

  /// Delete ingredient by ID
  void deleteById(String id) {
    if (_ingredients.containsKey(id)) {
      _ingredients.remove(id);
      notifyListeners();
    }
  }

  /// Delete ingredient by object
  void deleteByObject(Ingredient ingredient) {
    if (ingredient.id != null &&
        ingredient.id!.isNotEmpty &&
        _ingredients.containsKey(ingredient.id)) {
      _ingredients.remove(ingredient.id);
      notifyListeners();
    }
  }

  /// Add new ingredient
  void create(Ingredient ingredient) {
    final id = Random().nextDouble().toString();
    _ingredients[id] = Ingredient(
      id: id,
      name: ingredient.name,
      quantity: ingredient.quantity,
      unitLabel: ingredient.unitLabel,
      costPerUnit: ingredient.costPerUnit,
      totalCost: ingredient.totalCost,
    );
    notifyListeners();
  }
}
