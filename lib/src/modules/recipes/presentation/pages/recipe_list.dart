import 'package:flutter/material.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/core/mocks/recipe_mock.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/card_recipe.dart';
import 'package:reseller/src/shared/widgets/modal.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  static final List<Recipe> recipes = [...RECIPES_MOCK.values];

  void _openModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) => Modal(
        title: "Adicionar",
        child: const Text("Funcionalidade em construção"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openModal(context),
              icon: const Icon(Icons.add),
              label: const Text("Nova receita"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardRecipe.icon(
                      icon: Icons.restaurant,
                      recipe: recipe,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.recipesInfo,
                        arguments: recipe,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
