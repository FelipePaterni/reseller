import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

/// Modelo de transferência de dados (DTO) para Ingredient
///
/// Diferente de Ingredient (Entity):
/// - IngredientModel é usado na camada Data (serialização, banco de dados)
/// - Ingredient (Entity) é usado na camada Domain (lógica de negócio)
/// - O mapeamento entre eles é responsabilidade da camada Data
class IngredientModel {
  final String? id;
  final String name;
  final String unitLabel;
  final double quantity;
  final double totalCost;
  final double costPerUnit;

  IngredientModel({
    this.id,
    this.name = '',
    this.unitLabel = '',
    this.quantity = 0.0,
    this.totalCost = 0.0,
    this.costPerUnit = 0.0,
  });

  /// Converte IngredientModel para Entity Ingredient
  /// Responsabilidade da camada Data: mapear modelo para entidade
  Ingredient toEntity() {
    return Ingredient(
      id: id,
      name: name,
      unitLabel: unitLabel,
      quantity: quantity,
      totalCost: totalCost,
      costPerUnit: costPerUnit,
    );
  }

  /// Cria IngredientModel a partir de Entity Ingredient
  factory IngredientModel.fromEntity(Ingredient ingredient) {
    return IngredientModel(
      id: ingredient.id,
      name: ingredient.name,
      unitLabel: ingredient.unitLabel,
      quantity: ingredient.quantity,
      totalCost: ingredient.totalCost,
      costPerUnit: ingredient.costPerUnit,
    );
  }

  IngredientModel copyWith({
    String? id,
    String? name,
    String? unitLabel,
    double? quantity,
    double? totalCost,
    double? costPerUnit,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unitLabel: unitLabel ?? this.unitLabel,
      quantity: quantity ?? this.quantity,
      totalCost: totalCost ?? this.totalCost,
      costPerUnit: costPerUnit ?? this.costPerUnit,
    );
  }
}
