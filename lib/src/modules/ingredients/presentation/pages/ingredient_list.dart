import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredients.dart';
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            final ingredient = Ingredient(
              id: '1',
              title: 'Tomato',
              quantity: 10,
              totalCost: 25.0,
              costPerUnitLabel: 'kg',
              costPerUnit: 2.5,
            );

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
