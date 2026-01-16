import 'package:reseller/src/core/mocks/recipe_mock.dart';
import 'package:reseller/src/modules/recipes/data/datasource/recipes_datasource.dart';
import 'package:reseller/src/modules/recipes/data/models/recipe_model.dart';
import 'package:uuid/uuid.dart';

/// Implementação local (em memória) do RecipesDataSource
///
/// Camada Data - Responsabilidade: Acesso aos dados
/// - Implementa RecipesDataSource
/// - Trabalha com RecipeModel (DTOs)
/// - Pode ser substituído por implementação com banco de dados, API, etc.
/// - Independente da lógica de negócio
class RecipesLocalDataSourceImpl implements RecipesDataSource {
  // Simula banco de dados em memória
  final Map<String, RecipeModel> _recipes = {};

  RecipesLocalDataSourceImpl() {
    // Carrega dados mock inicialmente
    _initializeMockData();
  }

  /// Inicializa com dados mock
  void _initializeMockData() {
    for (var recipe in RECIPES_MOCK.values) {
      final model = RecipeModel.fromEntity(recipe);
      _recipes[model.id ?? const Uuid().v4()] = model;
    }
  }

  @override
  Future<List<RecipeModel>> getAll() async {
    // Simula latência de acesso
    await Future.delayed(const Duration(milliseconds: 100));
    return _recipes.values.toList();
  }

  @override
  Future<RecipeModel> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final recipe = _recipes[id];
    if (recipe == null) {
      throw Exception('Recipe with id $id not found');
    }
    return recipe;
  }

  @override
  Future<RecipeModel> save(RecipeModel recipe) async {
    await Future.delayed(const Duration(milliseconds: 50));

    final id = recipe.id?.isNotEmpty == true ? recipe.id! : const Uuid().v4();

    final newRecipe = recipe.copyWith(id: id);
    _recipes[id] = newRecipe;
    return newRecipe;
  }

  @override
  Future<void> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _recipes.remove(id);
  }

  @override
  Future<int> count() async {
    await Future.delayed(const Duration(milliseconds: 25));
    return _recipes.length;
  }
}
