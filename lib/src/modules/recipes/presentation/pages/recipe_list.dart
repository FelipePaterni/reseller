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
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => _openModal(context),
              icon: const Icon(Icons.add),
              label: const Text("Nova receita"),
            ),
            Expanded(
              child: Consumer<RecipesProvider>(
                builder: (context, provider, _) {
                  return provider.all.isEmpty
                      ? Center(
                          child: Text(
                            'Nenhuma receita encontrada.\nClique em "Nova receita" para adicionar uma.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        )
                      : ListView.builder(
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
