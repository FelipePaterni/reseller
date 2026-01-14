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
  String unitLabel;
  double _quantity;
  double _totalCost;
  double _costPerUnit;

  Ingredient({
    this.id,
    this.name = "",
    this.unitLabel = "",
    double quantity = 0,
    double totalCost = 0,

    double costPerUnit = 0,
  }) : _quantity = quantity,
       _totalCost = totalCost,
       _costPerUnit = costPerUnit;

  double get quantity => _quantity;
  double get totalCost => _totalCost;
  double get costPerUnit => _costPerUnit;

  set quantity(double value) {
    _quantity = value;
    _recalculateCostPerUnit();
  }

  set totalCost(double value) {
    _totalCost = value;
    _recalculateCostPerUnit();
  }

  void _recalculateCostPerUnit() {
    _costPerUnit = (_quantity > 0 ? _totalCost / _quantity : 0);
    _costPerUnit = (_costPerUnit * 100).round() / 100;
  }

  factory Ingredient.empty() {
    return Ingredient(
      id: null,
      name: "",
      unitLabel: "",
      quantity: 0,
      totalCost: 0,
      costPerUnit: 0,
    );
  }
}
