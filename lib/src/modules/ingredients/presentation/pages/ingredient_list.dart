import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/ingredients/data/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/card_ingredients.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/ingredient_edit_sheet.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({super.key});

  void _openEditModal(BuildContext context, Ingredient ingredient) {
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

  @override
  Widget build(BuildContext context) {
    final IngredientsProvider ingredients = Provider.of<IngredientsProvider>(
      context,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _openEditModal(context, Ingredient());
              },
              icon: Icon(Icons.add),
              label: Text("Novo Ingrediente"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.count,
                itemBuilder: (context, index) {
                  final ingredient = ingredients.getByIndex(index);
                  return CardIngredients(
                    ingredient: ingredient,
                    onTap: () => _openEditModal(context, ingredient),
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
