import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

/// Repository interface for managing ingredients
///
/// Defines contracts for CRUD operations on ingredients.
/// Implementations should be placed in data/repositories/
abstract class IngredientsRepository {
  /// Get all ingredients
  Future<List<Ingredient>> getAll();

  /// Get ingredient by ID
  Future<Ingredient?> getById(String id);

  /// Save (create or update) an ingredient
  Future<void> save(Ingredient ingredient);

  /// Delete ingredient by ID
  Future<void> delete(String id);
}
