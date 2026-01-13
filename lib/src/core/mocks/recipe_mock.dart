import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

// ignore: constant_identifier_names
const Map<String, Recipe> RECIPES_MOCK = {
  '1': Recipe(title: 'Pizza', description: 'some pizza', ingredientsIds: []),
  '2': Recipe(
    title: 'Chocolate Cake',
    description: 'Rich and moist chocolate cake',
    ingredientsIds: ["2"],
  ),
  '3': Recipe(
    title: 'Pasta Carbonara',
    description: 'Classic Italian pasta dish',
    ingredientsIds: ["1"],
  ),
  '4': Recipe(
    title: 'Caesar Salad',
    description: 'Fresh green salad with croutons',
    ingredientsIds: ["1", "2"],
  ),
};
