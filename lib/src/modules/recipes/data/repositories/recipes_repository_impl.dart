import 'package:reseller/src/modules/recipes/data/datasource/recipes_datasource.dart';
import 'package:reseller/src/modules/recipes/data/models/recipe_model.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository.dart';

/// Implementação concreta do RecipesRepository
///
/// Camada Data - Responsabilidade: Orquestrar acesso aos dados
/// - Implementa a interface RecipesRepository (contrato do Domain)
/// - Delega operações para RecipesDataSource (acesso concreto)
/// - Mapeia entre RecipeModel (dados) e Recipe (entidade de negócio)
/// - Centraliza a lógica de qual DataSource usar (local, remoto, etc)
class RecipesRepositoryImpl implements RecipesRepository {
  final RecipesDataSource dataSource;

  RecipesRepositoryImpl({required this.dataSource});

  @override
  Future<List<Recipe>> getAll() async {
    final models = await dataSource.getAll();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Recipe?> getById(String id) async {
    try {
      final model = await dataSource.getById(id);
      return model.toEntity();
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> save(Recipe recipe) async {
    // Mapeia entidade para modelo antes de salvar
    final model = RecipeModel.fromEntity(recipe);
    await dataSource.save(model);
  }

  @override
  Future<void> delete(String id) async {
    await dataSource.delete(id);
  }

  @override
  Future<int> count() async {
    return dataSource.count();
  }
}
