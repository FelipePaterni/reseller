import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/card_ingredients.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/ingredient_edit_sheet.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({super.key});

  static const List<Ingredient> ingredients = [];

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            final ingredient = ingredients[index];
            return CardIngredients(
              ingredient: ingredient,
              onTap: () => _openEditModal(context, ingredient),
            );
          },
        ),
      ),
    );
  }
}
