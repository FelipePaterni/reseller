import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/core/theme/app_colors.dart';

class IngredientTotalRecipe extends StatelessWidget {
  const IngredientTotalRecipe({
    super.key,
    required this.selectedIngredient,
    required this.theme,
    required this.quantity,
  });
  final Ingredient selectedIngredient;
  final ThemeData theme;
  final double quantity;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unidade:', style: theme.textTheme.bodyMedium),
              Text(
                selectedIngredient.unitLabel,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Custo unitário:', style: theme.textTheme.bodyMedium),
              Text(
                'R\$ ${selectedIngredient.costPerUnit.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Custo total na receita:',
                style: theme.textTheme.titleSmall,
              ),
              Text(
                'R\$ ${(selectedIngredient.costPerUnit * quantity).toStringAsFixed(2)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.brandAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
