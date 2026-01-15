import 'package:reseller/src/core/mocks/ingredients_mock.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/domain/repositories/ingredients_repository.dart';
import 'package:uuid/uuid.dart';

/// Mock implementation of IngredientsRepository
///
/// Uses in-memory Map for storage with mock data.
/// For production, create implementations like IngredientsRepositoryLocal, IngredientsRepositoryRemote, etc.
class IngredientsRepositoryMock implements IngredientsRepository {
  final Map<String, Ingredient> _ingredients = {...INGREDIENTS_MOCK};

  @override
  Future<List<Ingredient>> getAll() async {
    return _ingredients.values.toList();
  }

  @override
  Future<Ingredient?> getById(String id) async {
    return _ingredients[id];
  }

  @override
  Future<void> save(Ingredient ingredient) async {
    final id = ingredient.id?.isNotEmpty == true
        ? ingredient.id!
        : const Uuid().v4();

    _ingredients[id] = ingredient.copyWith(id: id);
  }

  @override
  Future<void> delete(String id) async {
    _ingredients.remove(id);
  }
}
