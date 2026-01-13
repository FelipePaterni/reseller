import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

class CardIngredients extends StatelessWidget {
  final Ingredient ingredient;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CardIngredients({
    super.key,
    required this.ingredient,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with title and edit icon
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit, size: 20, color: colorScheme.primary),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, size: 20, color: colorScheme.error),
                ),
              ],
            ),

            // Quantity and label row
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  padding: const EdgeInsets.all(0),
                  label: Text(
                    'Qtd: ${ingredient.quantity} ${ingredient.unitLabel}',
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    textHeightBehavior: const TextHeightBehavior(
                      applyHeightToFirstAscent: false,
                      applyHeightToLastDescent: false,
                    ),
                  ),
                ),
                Text(
                  'CUSTO POR UNIDADE',
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    letterSpacing: 0.7,
                  ),
                ),
              ],
            ),

            // Total and cost per unit row
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total: R\$ ${ingredient.totalCost}',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'R\$ ${ingredient.costPerUnit}',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/ ${ingredient.unitLabel}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
