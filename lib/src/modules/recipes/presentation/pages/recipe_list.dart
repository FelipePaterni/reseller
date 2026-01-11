import 'package:flutter/material.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/card_recipe.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  static const List<Recipe> recipes = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CardRecipe.icon(
              icon: recipe.icon ?? Icons.restaurant,
              title: recipe.title,
              content: recipe.description,
              onTap: () => Navigator.pushNamed(
                context,
                Routes.recipesInfo,
                arguments: recipe,
              ),
            ),
          );
        },
      ),
    );
  }
}
