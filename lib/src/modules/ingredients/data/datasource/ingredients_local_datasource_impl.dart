import 'package:reseller/src/core/mocks/ingredients_mock.dart';
import 'package:reseller/src/modules/ingredients/data/datasource/ingredients_datasource.dart';
import 'package:reseller/src/modules/ingredients/data/models/ingredient_model.dart';
import 'package:uuid/uuid.dart';

/// Implementação local (em memória) do IngredientsDataSource
///
/// Camada Data - Responsabilidade: Acesso aos dados
/// - Implementa IngredientsDataSource
/// - Trabalha com IngredientModel (DTOs)
/// - Pode ser substituído por implementação com banco de dados, API, etc.
/// - Independente da lógica de negócio
class IngredientsLocalDataSourceImpl implements IngredientsDataSource {
  // Simula banco de dados em memória
  final Map<String, IngredientModel> _ingredients = {};

  IngredientsLocalDataSourceImpl() {
    // Carrega dados mock inicialmente
    _initializeMockData();
  }

  /// Inicializa com dados mock
  void _initializeMockData() {
    for (var ingredient in INGREDIENTS_MOCK.values) {
      final model = IngredientModel.fromEntity(ingredient);
      _ingredients[model.id ?? const Uuid().v4()] = model;
    }
  }

  @override
  Future<List<IngredientModel>> getAll() async {
    // Simula latência de acesso
    await Future.delayed(const Duration(milliseconds: 100));
    return _ingredients.values.toList();
  }

  @override
  Future<IngredientModel> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final ingredient = _ingredients[id];
    if (ingredient == null) {
      throw Exception('Ingredient with id $id not found');
    }
    return ingredient;
  }

  @override
  Future<IngredientModel> save(IngredientModel ingredient) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final id = ingredient.id?.isNotEmpty == true
        ? ingredient.id!
        : const Uuid().v4();

    final newIngredient = ingredient.copyWith(id: id);
    _ingredients[id] = newIngredient;
    return newIngredient;
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _ingredients.remove(id);
  }

  @override
  Future<int> count() async {
    await Future.delayed(const Duration(milliseconds: 25));
    return _ingredients.length;
  }
}
