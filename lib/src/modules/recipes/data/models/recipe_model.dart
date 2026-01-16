import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

/// Modelo de transferência de dados (DTO) para Recipe
///
/// Diferente de Recipe (Entity):
/// - RecipeModel é usado na camada Data (serialização, banco de dados)
/// - Recipe (Entity) é usado na camada Domain (lógica de negócio)
/// - O mapeamento entre eles é responsabilidade da camada Data
class RecipeModel {
  final String? id;
  final String imagePath;
  final String name;
  final double yieldRecipe;
  final List<RecipeItemModel> items;

  RecipeModel({
    this.id,
    this.imagePath = '',
    this.name = '',
    this.yieldRecipe = 1.0,
    this.items = const [],
  });

  /// Converte RecipeModel para Entity Recipe
  /// Responsabilidade da camada Data: mapear modelo para entidade
  Recipe toEntity() {
    return Recipe(
      id: id,
      imagePath: imagePath,
      name: name,
      yieldRecipe: yieldRecipe,
      items: items.map((item) => item.toEntity()).toList(),
    );
  }

  /// Cria RecipeModel a partir de Entity Recipe
  factory RecipeModel.fromEntity(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      imagePath: recipe.imagePath,
      name: recipe.name,
      yieldRecipe: recipe.yieldRecipe,
      items: recipe.items
          .map((item) => RecipeItemModel.fromEntity(item))
          .toList(),
    );
  }

  RecipeModel copyWith({
    String? id,
    String? imagePath,
    String? name,
    double? yieldRecipe,
    List<RecipeItemModel>? items,
  }) {
    return RecipeModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      yieldRecipe: yieldRecipe ?? this.yieldRecipe,
      items: items ?? this.items,
    );
  }
}

/// Modelo de transferência de dados para RecipeItem
class RecipeItemModel {
  final String ingredientId; // Apenas ID, não a entidade completa
  final String ingredientName;
  final double costPerUnit;
  final double quantity;

  RecipeItemModel({
    required this.ingredientId,
    required this.ingredientName,
    required this.costPerUnit,
    required this.quantity,
  });

  double get totalCost => costPerUnit * quantity;

  /// Converte para Entity RecipeItem
  RecipeItem toEntity() {
    // Aqui você precisaria recuperar o Ingredient completo
    // Por enquanto, retorna um Ingredient básico
    // Em um cenário real, o Repository faria isso
    return RecipeItem(
      ingredient: Ingredient(
        id: ingredientId,
        name: ingredientName,
        costPerUnit: costPerUnit,
      ),
      quantity: quantity,
    );
  }

  factory RecipeItemModel.fromEntity(RecipeItem item) {
    return RecipeItemModel(
      ingredientId: item.ingredient.id ?? 'unknown',
      ingredientName: item.ingredient.name,
      costPerUnit: item.ingredient.costPerUnit,
      quantity: item.quantity,
    );
  }

  RecipeItemModel copyWith({
    String? ingredientId,
    String? ingredientName,
    double? costPerUnit,
    double? quantity,
  }) {
    return RecipeItemModel(
      ingredientId: ingredientId ?? this.ingredientId,
      ingredientName: ingredientName ?? this.ingredientName,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      quantity: quantity ?? this.quantity,
    );
  }
}
