import 'package:reseller/src/modules/recipes/data/models/recipe_model.dart';

/// DataSource abstrato para operações com Recipes
///
/// Define o contrato que implementações concretas (LocalDataSource, RemoteDataSource)
/// devem seguir. Separa a lógica de acesso aos dados da lógica de negócio.
abstract class RecipesDataSource {
  /// Recupera todas as receitas
  Future<List<RecipeModel>> getAll();

  /// Recupera uma receita pelo ID
  /// Lança exceção se não encontrada
  Future<RecipeModel> getById(String id);

  /// Salva ou atualiza uma receita
  /// Se o modelo não tiver ID, gera um novo
  Future<RecipeModel> save(RecipeModel recipe);

  /// Deleta uma receita pelo ID
  Future<void> delete(String id);

  /// Retorna o total de receitas
  Future<int> count();
}
