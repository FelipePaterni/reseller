import 'package:flutter/material.dart';
import 'package:reseller/src/core/mocks/ingredients_mock.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:uuid/uuid.dart';

/// Provider for managing ingredients state
class IngredientsProvider with ChangeNotifier {
  final Map<String, Ingredient> _ingredients = {...INGREDIENTS_MOCK};

  List<Ingredient> get getAll => [..._ingredients.values];

  int get count => _ingredients.length;

  Ingredient? getById(String id) => _ingredients[id];

  Ingredient getByIndex(int index) {
    if (index < 0 || index >= _ingredients.length) {
      throw RangeError('Index out of range');
    }
    return _ingredients.values.elementAt(index);
  }

  /// Create or update an ingredient
  ///
  /// If the [ingredient] has an ID and exists, it updates it.
  /// Otherwise, it creates a new [ingredient] with a new ID.
  void createOrUpdate(Ingredient ingredient) {
    if (ingredient.id != null &&
        ingredient.id!.isNotEmpty &&
        _ingredients.containsKey(ingredient.id)) {
      _ingredients[ingredient.id!] = ingredient;
    } else {
      final id = Uuid().v4();

      _ingredients[id] = Ingredient(
        id: id,
        name: ingredient.name,
        quantity: ingredient.quantity,
        unitLabel: ingredient.unitLabel,
        costPerUnit: ingredient.costPerUnit,
        totalCost: ingredient.totalCost,
      );
    }
    notifyListeners();
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
}
