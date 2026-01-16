import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/card_ingredients.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/ingredient_delete_sheet.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/ingredient_edit_sheet.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({super.key});

  void _openModal(BuildContext context, Ingredient ingredient) {
    showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) => IngredientEditSheet(ingredient: ingredient),
    );
  }

  void _openDeleteModal(BuildContext context, Ingredient ingredient) {
    showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) => IngredientDeleteSheet(ingredient: ingredient),
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
          spacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => _openModal(context, Ingredient.empty()),
              icon: const Icon(Icons.add),
              label: const Text("Novo Ingrediente"),
            ),
            Expanded(
              child: Consumer<IngredientsProvider>(
                builder: (context, provider, _) {
                  final ingredientsList = provider.all;
                  if (ingredientsList.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum ingrediente encontrado.\nClique em "Novo Ingrediente" para adicionar um.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: ingredientsList.length,
                    itemBuilder: (context, index) {
                      final ingredient = ingredientsList[index];
                      return CardIngredients(
                        ingredient: ingredient,
                        onEdit: () => _openModal(context, ingredient),
                        onDelete: () => _openDeleteModal(context, ingredient),
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
