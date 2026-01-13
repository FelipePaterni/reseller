import 'package:reseller/src/core/mocks/ingredients_mock.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';

// ignore: non_constant_identifier_names
final Map<String, Recipe> RECIPES_MOCK = {
  '1': Recipe(
    id: '1',
    name: 'Pizza',
    yieldRecipe: 2.0,
    imagePath: "assets/images/pizza.png",
    items: [
      RecipeItem(ingredient: INGREDIENTS_MOCK['1']!, quantity: 2.0),
      RecipeItem(ingredient: INGREDIENTS_MOCK['2']!, quantity: 5.0),
    ],
  ),
  '2': Recipe(
    id: '2',
    name: 'Chocolate Cake',
    yieldRecipe: 8.0,
    imagePath: "assets/images/chocolate_cake.png",
    items: [
      RecipeItem(ingredient: INGREDIENTS_MOCK['2']!, quantity: 250.0),
      RecipeItem(ingredient: INGREDIENTS_MOCK['3']!, quantity: 200.0),
    ],
  ),
  '3': Recipe(
    id: '3',
    name: 'Pasta Carbonara',
    yieldRecipe: 4.0,
    items: [
      RecipeItem(ingredient: INGREDIENTS_MOCK['1']!, quantity: 400.0),
      RecipeItem(ingredient: INGREDIENTS_MOCK['4']!, quantity: 150.0),
    ],
  ),
  '4': Recipe(
    id: '4',
    name: 'Caesar Salad',
    yieldRecipe: 2.0,
    items: [
      RecipeItem(ingredient: INGREDIENTS_MOCK['1']!, quantity: 300.0),
      RecipeItem(ingredient: INGREDIENTS_MOCK['2']!, quantity: 200.0),
    ],
  ),
};
