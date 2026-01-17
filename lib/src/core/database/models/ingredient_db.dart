import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/data/models/ingredient_model.dart';

/// Modelo de banco de dados para Ingredient
///
/// Responsabilidade: Representar dados do Ingredient conforme armazenado em SQLite
/// Separa a representação em BD da representação em camadas Domain/Data
class IngredientDB {
  final String id;
  final String name;
  final String unitLabel;
  final double quantity;
  final double totalCost;
  final double costPerUnit;
  final String createdAt;
  final String updatedAt;

  const IngredientDB({
    required this.id,
    required this.name,
    required this.unitLabel,
    required this.quantity,
    required this.totalCost,
    required this.costPerUnit,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Converte IngredientDB para Map (para salvar em SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'unit_label': unitLabel,
      'quantity': quantity,
      'total_cost': totalCost,
      'cost_per_unit': costPerUnit,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Cria IngredientDB a partir de Map (vindo do SQLite)
  factory IngredientDB.fromMap(Map<String, dynamic> map) {
    return IngredientDB(
      id: map['id'] as String,
      name: map['name'] as String,
      unitLabel: map['unit_label'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      totalCost: (map['total_cost'] as num).toDouble(),
      costPerUnit: (map['cost_per_unit'] as num).toDouble(),
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  /// Converte IngredientDB para Entity (camada Domain)
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

  /// Cria IngredientDB a partir de Entity
  factory IngredientDB.fromEntity(Ingredient ingredient) {
    final now = DateTime.now().toIso8601String();
    return IngredientDB(
      id: ingredient.id ?? '',
      name: ingredient.name,
      unitLabel: ingredient.unitLabel,
      quantity: ingredient.quantity,
      totalCost: ingredient.totalCost,
      costPerUnit: ingredient.costPerUnit,
      createdAt: ingredient.id != null ? now : now,
      updatedAt: now,
    );
  }

  /// Converte IngredientDB para IngredientModel (DTO da camada Data)
  IngredientModel toModel() {
    return IngredientModel(
      id: id,
      name: name,
      unitLabel: unitLabel,
      quantity: quantity,
      totalCost: totalCost,
      costPerUnit: costPerUnit,
    );
  }

  /// Cria IngredientDB a partir de IngredientModel
  factory IngredientDB.fromModel(IngredientModel model) {
    final now = DateTime.now().toIso8601String();
    return IngredientDB(
      id: model.id ?? '',
      name: model.name,
      unitLabel: model.unitLabel,
      quantity: model.quantity,
      totalCost: model.totalCost,
      costPerUnit: model.costPerUnit,
      createdAt: model.id != null ? now : now,
      updatedAt: now,
    );
  }

  @override
  String toString() =>
      'IngredientDB(id: $id, name: $name, quantity: $quantity)';
}
