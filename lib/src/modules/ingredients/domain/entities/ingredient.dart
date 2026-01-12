/// Ingredient entity
/// Represents an ingredient with its details.
///
/// [id] - Unique identifier for the ingredient **(auto-generated)**.
///
/// [name] - Name of the ingredient.
///
/// [quantity] - Quantity of the ingredient in the purchase.
///
/// [totalCost] - Total cost of the ingredient in the purchase.
///
/// [unitLabel] - Unit label for the quantity (e.g., grams, cups).
///
/// [costPerUnit] - Cost per unit of the ingredient **(auto-calculated)**.
///
/// Example:
/// ```dart
///  ingredient = Ingredient(
///   id: '1',
///   name: 'Tomato',
///   quantity: 2.0,
///   totalCost: 3.0,
///   unitLabel: 'kg',
///   costPerUnit: 1.5,
/// );
/// ```
class Ingredient {
  String? id;
  String name;
  double quantity;
  double totalCost;
  String unitLabel;
  double costPerUnit;

  Ingredient({
    this.id,
    this.name = "",
    this.quantity = 0,
    this.totalCost = 0,
    this.unitLabel = "",
    this.costPerUnit = 0,
  });

  set setName(String name) {
    this.name = name;
  }

  set setUnitLabel(String unitLabel) {
    this.unitLabel = unitLabel;
  }

  set setQuantity(double quantity) {
    this.quantity = quantity;
    recalculateCostPerUnit();
  }

  set setTotalCost(double totalCost) {
    this.totalCost = totalCost;
    recalculateCostPerUnit();
  }

  void recalculateCostPerUnit() {
    costPerUnit = (quantity > 0 ? totalCost / quantity : 0);
    costPerUnit = double.tryParse(costPerUnit.toStringAsFixed(2)) ?? 0.00;
  }
}
