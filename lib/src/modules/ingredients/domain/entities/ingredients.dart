class Ingredient {
  final String? id;
  final String title;
  final double quantity;
  final double totalCost;
  final String costPerUnitLabel;
  final double costPerUnit;

  const Ingredient({
    this.id,
    required this.title,
    required this.quantity,
    required this.totalCost,
    required this.costPerUnitLabel,
    required this.costPerUnit,
  });
}
