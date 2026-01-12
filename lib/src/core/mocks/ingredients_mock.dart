import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

// ignore: non_constant_identifier_names
Map<String, Ingredient> INGREDIENTS_MOCK = {
  '1': Ingredient(
    id: '1',
    name: 'Tomato',
    quantity: 2.0,
    totalCost: 3.0,
    unitLabel: 'kg',
    costPerUnit: 1.5,
  ),
  '2': Ingredient(
    id: '2',
    name: 'Onion',
    quantity: 1.5,
    totalCost: 2.25,
    unitLabel: 'kg',
    costPerUnit: 1.5,
  ),
};
