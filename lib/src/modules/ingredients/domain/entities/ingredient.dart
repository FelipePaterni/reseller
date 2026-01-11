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
/// const ingredient = Ingredient(
///   id: '1',
///   name: 'Tomato',
///   quantity: 2.0,
///   totalCost: 3.0,
///   unitLabel: 'kg',
///   costPerUnit: 1.5,
/// );
/// ```
interface class Ingredient {
  final String? id;
  final String name;
  final double quantity;
  final double totalCost;
  final String unitLabel;
  final double costPerUnit;

  const Ingredient({
    this.id,
    required this.name,
    required this.quantity,
    required this.totalCost,
    required this.unitLabel,
    required this.costPerUnit,
  });
}
