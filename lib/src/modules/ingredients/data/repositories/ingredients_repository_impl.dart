import 'package:reseller/src/modules/ingredients/data/datasource/ingredients_datasource.dart';
import 'package:reseller/src/modules/ingredients/data/models/ingredient_model.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/domain/repositories/ingredients_repository.dart';

/// Implementação concreta do IngredientsRepository
///
/// Camada Data - Responsabilidade: Orquestrar acesso aos dados
/// - Implementa a interface IngredientsRepository (contrato do Domain)
/// - Delega operações para IngredientsDataSource (acesso concreto)
/// - Mapeia entre IngredientModel (dados) e Ingredient (entidade de negócio)
/// - Centraliza a lógica de qual DataSource usar (local, remoto, etc)
class IngredientsRepositoryImpl implements IngredientsRepository {
  final IngredientsDataSource dataSource;

  IngredientsRepositoryImpl({required this.dataSource});

  @override
  Future<List<Ingredient>> getAll() async {
    final models = await dataSource.getAll();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Ingredient?> getById(String id) async {
    try {
      final model = await dataSource.getById(id);
      return model.toEntity();
    } on Exception {
      return null;
    }
  }

  @override
  Future<void> save(Ingredient ingredient) async {
    // Mapeia entidade para modelo antes de salvar
    final model = IngredientModel.fromEntity(ingredient);
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
