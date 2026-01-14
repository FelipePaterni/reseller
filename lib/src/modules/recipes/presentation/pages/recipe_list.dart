import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/app/router/routes.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/card_recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/recipe_edit_sheet.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});
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
      builder: (sheetContext) => const RecipeEditSheet(),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => _openModal(context),
              icon: const Icon(Icons.add),
              label: const Text("Nova receita"),
            ),
            Expanded(
              child: Consumer<RecipesProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    itemCount: provider.count,
                    itemBuilder: (context, index) {
                      final recipe = provider.all[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardRecipe(
                          icon: Icons.restaurant,
                          recipe: recipe,
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routes.recipesInfo,
                            arguments: recipe.id,
                          ),
                        ),
                      );
                    },
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
