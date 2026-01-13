import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

abstract class RecipesRepository {
  Future<List<Recipe>> getAll();
  Future<Recipe?> getById(String id);
  Future<void> save(Recipe recipe);
  Future<void> delete(String id);
}
