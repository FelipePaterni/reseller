import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/data/models/recipe_model.dart';

/// Modelo de banco de dados para Recipe
///
/// Responsabilidade: Representar dados da Recipe conforme armazenado em SQLite
class RecipeDB {
  final String id;
  final String name;
  final double yieldRecipe;
  final String? imagePath;
  final String createdAt;
  final String updatedAt;

  const RecipeDB({
    required this.id,
    required this.name,
    required this.yieldRecipe,
    this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Converte RecipeDB para Map (para salvar em SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'yield_recipe': yieldRecipe,
      'image_path': imagePath,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Cria RecipeDB a partir de Map (vindo do SQLite)
  factory RecipeDB.fromMap(Map<String, dynamic> map) {
    return RecipeDB(
      id: map['id'] as String,
      name: map['name'] as String,
      yieldRecipe: (map['yield_recipe'] as num).toDouble(),
      imagePath: map['image_path'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  /// Converte RecipeDB para Entity (camada Domain)
  /// Nota: items são carregados separadamente via recipe_items table
  Recipe toEntity({List<RecipeItem> items = const []}) {
    return Recipe(
      id: id,
      name: name,
      yieldRecipe: yieldRecipe,
      imagePath: imagePath ?? '',
      items: items,
    );
  }

  /// Cria RecipeDB a partir de Entity
  factory RecipeDB.fromEntity(Recipe recipe) {
    final now = DateTime.now().toIso8601String();
    return RecipeDB(
      id: recipe.id ?? '',
      name: recipe.name,
      yieldRecipe: recipe.yieldRecipe,
      imagePath: recipe.imagePath.isEmpty ? null : recipe.imagePath,
      createdAt: recipe.id != null ? now : now,
      updatedAt: now,
    );
  }

  /// Converte RecipeDB para RecipeModel (DTO da camada Data)
  RecipeModel toModel({List<RecipeItemModel> items = const []}) {
    return RecipeModel(
      id: id,
      name: name,
      yieldRecipe: yieldRecipe,
      imagePath: imagePath ?? '',
      items: items,
    );
  }

  /// Cria RecipeDB a partir de RecipeModel
  factory RecipeDB.fromModel(RecipeModel model) {
    final now = DateTime.now().toIso8601String();
    return RecipeDB(
      id: model.id ?? '',
      name: model.name,
      yieldRecipe: model.yieldRecipe,
      imagePath: model.imagePath.isEmpty ? null : model.imagePath,
      createdAt: model.id != null ? now : now,
      updatedAt: now,
    );
  }

  @override
  String toString() => 'RecipeDB(id: $id, name: $name, yield: $yieldRecipe)';
}

/// Modelo de banco de dados para RecipeItem (item de receita)
class RecipeItemDB {
  final String id;
  final String recipeId;
  final String ingredientId;
  final String ingredientName;
  final double costPerUnit;
  final double quantity;
  final String createdAt;

  const RecipeItemDB({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    required this.ingredientName,
    required this.costPerUnit,
    required this.quantity,
    required this.createdAt,
  });

  /// Converte RecipeItemDB para Map (para salvar em SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recipe_id': recipeId,
      'ingredient_id': ingredientId,
      'ingredient_name': ingredientName,
      'cost_per_unit': costPerUnit,
      'quantity': quantity,
      'created_at': createdAt,
    };
  }

  /// Cria RecipeItemDB a partir de Map (vindo do SQLite)
  factory RecipeItemDB.fromMap(Map<String, dynamic> map) {
    return RecipeItemDB(
      id: map['id'] as String,
      recipeId: map['recipe_id'] as String,
      ingredientId: map['ingredient_id'] as String,
      ingredientName: map['ingredient_name'] as String,
      costPerUnit: (map['cost_per_unit'] as num).toDouble(),
      quantity: (map['quantity'] as num).toDouble(),
      createdAt: map['created_at'] as String,
    );
  }

  /// Converte RecipeItemDB para RecipeItemModel (DTO)
  RecipeItemModel toModel() {
    return RecipeItemModel(
      ingredientId: ingredientId,
      ingredientName: ingredientName,
      costPerUnit: costPerUnit,
      quantity: quantity,
    );
  }

  /// Cria RecipeItemDB a partir de RecipeItemModel
  factory RecipeItemDB.fromModel(String recipeId, RecipeItemModel model) {
    return RecipeItemDB(
      id: '${recipeId}_${model.ingredientId}',
      recipeId: recipeId,
      ingredientId: model.ingredientId,
      ingredientName: model.ingredientName,
      costPerUnit: model.costPerUnit,
      quantity: model.quantity,
      createdAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  String toString() =>
      'RecipeItemDB(id: $id, ingredient: $ingredientName, qty: $quantity)';
}
