import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';

class IngredientDeleteSheet extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientDeleteSheet({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Delete Icon in Red Circle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.error.withAlpha(26),
            ),
            child: Icon(
              Icons.delete_forever,
              size: 36,
              color: colorScheme.error,
            ),
          ),
          const SizedBox(height: 24),

          // Headline
          Text(
            'Excluir Ingrediente?',
            style: textTheme.headlineMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Description Text
          Text(
            'Tem certeza que deseja excluir este ingrediente? Esta ação não pode ser desfeita e afetará o custo das suas receitas.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha(204),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Button Group - Vertical Stack
          Column(
            spacing: 12,
            children: [
              // Delete Button (Error)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ingredient);
                    Provider.of<IngredientsProvider>(
                      context,
                      listen: false,
                    ).deleteById(ingredient.id!);
                  },
                  child: Text(
                    'Excluir',
                    style: textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    foregroundColor: colorScheme.onSurface,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(
                    'Cancelar',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
