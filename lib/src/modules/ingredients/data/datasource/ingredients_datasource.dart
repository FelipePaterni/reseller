import 'package:reseller/src/modules/ingredients/data/models/ingredient_model.dart';

/// DataSource abstrato para operações com Ingredients
///
/// Define o contrato que implementações concretas (LocalDataSource, RemoteDataSource)
/// devem seguir. Separa a lógica de acesso aos dados da lógica de negócio.
abstract class IngredientsDataSource {
  /// Recupera todos os ingredientes
  Future<List<IngredientModel>> getAll();

  /// Recupera um ingrediente pelo ID
  /// Lança exceção se não encontrado
  Future<IngredientModel> getById(String id);

  /// Salva ou atualiza um ingrediente
  /// Se o modelo não tiver ID, gera um novo
  Future<IngredientModel> save(IngredientModel ingredient);

  /// Deleta um ingrediente pelo ID
  Future<void> delete(String id);

  /// Retorna o total de ingredientes
  Future<int> count();
}
