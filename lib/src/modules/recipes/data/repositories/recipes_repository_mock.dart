import 'package:reseller/src/core/mocks/recipe_mock.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository.dart';
import 'package:uuid/uuid.dart';

/// Mock implementation of RecipesRepository
///
/// Uses in-memory Map for storage with mock data.
/// For production, create implementations like RecipesRepositoryLocal, RecipesRepositoryRemote, etc.
class RecipesRepositoryMock implements RecipesRepository {
  final Map<String, Recipe> _recipes = {...RECIPES_MOCK};

  @override
  Future<List<Recipe>> getAll() async {
    return _recipes.values.toList();
  }

  @override
  Future<Recipe?> getById(String id) async {
    return _recipes[id];
  }

  @override
  Future<void> save(Recipe recipe) async {
    final id = recipe.id?.isNotEmpty == true ? recipe.id! : const Uuid().v4();

    _recipes[id] = recipe.copyWith(id: id);
  }

  @override
  Future<void> delete(String id) async {
    _recipes.remove(id);
  }
}
