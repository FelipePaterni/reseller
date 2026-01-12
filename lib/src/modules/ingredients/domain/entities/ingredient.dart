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
  String? _id;
  String _name;
  double _quantity;
  double _totalCost;
  String _unitLabel;
  double _costPerUnit;

  Ingredient({
    String? id,
    String name = "",
    double quantity = 0,
    double totalCost = 0,
    String unitLabel = "",
    double costPerUnit = 0,
  }) : _id = id,
       _name = name,
       _quantity = quantity,
       _totalCost = totalCost,
       _unitLabel = unitLabel,
       _costPerUnit = costPerUnit;

  // Getters
  String? get id => _id;
  String get name => _name;
  double get quantity => _quantity;
  double get totalCost => _totalCost;
  String get unitLabel => _unitLabel;
  double get costPerUnit => _costPerUnit;

  // Setters
  set id(String? value) {
    _id = value;
  }

  set name(String value) {
    _name = value;
  }

  set unitLabel(String value) {
    _unitLabel = value;
  }

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

  void recalculateCostPerUnit() {
    _recalculateCostPerUnit();
  }
}
