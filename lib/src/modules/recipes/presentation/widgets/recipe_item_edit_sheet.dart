import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/core/theme/app_colors.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';

class RecipeItemEditSheet extends StatefulWidget {
  final String recipeId;
  final RecipeItem? recipeItem;
  final int? itemIndex;

  const RecipeItemEditSheet({
    super.key,
    required this.recipeId,
    this.recipeItem,
    this.itemIndex,
  });

  @override
  State<RecipeItemEditSheet> createState() => _RecipeItemEditSheetState();
}

class _RecipeItemEditSheetState extends State<RecipeItemEditSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  late Ingredient _selectedIngredient;
  late double _quantity;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.recipeItem != null) {
      _selectedIngredient = widget.recipeItem!.ingredient;
      _quantity = widget.recipeItem!.quantity;
    } else {
      _selectedIngredient = context.read<IngredientsProvider>().getAll.first;
      _quantity = 1.0;
    }
  }

  Future<void> _saveRecipeItem() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isLoading = true);

      try {
        final recipesProvider = Provider.of<RecipesProvider>(
          context,
          listen: false,
        );
        final newItem = RecipeItem(
          ingredient: _selectedIngredient,
          quantity: _quantity,
        );

        if (widget.itemIndex != null) {
          // Updating existing item
          await recipesProvider.updateRecipeItem(
            widget.recipeId,
            widget.itemIndex!,
            newItem,
          );
        } else {
          // Adding new item
          await recipesProvider.addRecipeItem(widget.recipeId, newItem);
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final ingredients = context.watch<IngredientsProvider>().getAll;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  widget.itemIndex != null
                      ? 'Editar Ingrediente'
                      : 'Adicionar Ingrediente',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            FormBuilderDropdown<Ingredient>(
              name: 'ingredient_select',
              initialValue: _selectedIngredient,
              decoration: const InputDecoration(
                labelText: 'Ingrediente',
                hintText: 'Selecione um ingrediente',
              ),
              items: ingredients
                  .map(
                    (ingredient) => DropdownMenuItem<Ingredient>(
                      value: ingredient,
                      child: Text(ingredient.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedIngredient = value);
                }
              },
              validator: (value) {
                if (value == null) {
                  return 'Selecione um ingrediente';
                }
                return null;
              },
            ),
            FormBuilderTextField(
              name: 'quantity',
              initialValue: _quantity.toString(),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Quantidade na receita',
                hintText: '0.0',
              ),
              onChanged: (value) => setState(
                () => _quantity = double.tryParse(value ?? '') ?? 0.0,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Informe a quantidade';
                }
                final quantity = double.tryParse(value);
                if (quantity == null || quantity <= 0) {
                  return 'Quantidade deve ser maior que zero';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                spacing: 8,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Unidade:', style: theme.textTheme.bodyMedium),
                      Text(
                        _selectedIngredient.unitLabel,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Custo unitário:',
                        style: theme.textTheme.bodyMedium,
                      ),
                      Text(
                        'R\$ ${_selectedIngredient.costPerUnit.toStringAsFixed(2)}',
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
                        'R\$ ${(_selectedIngredient.costPerUnit * _quantity).toStringAsFixed(2)}',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.brandAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).maybePop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isLoading ? null : _saveRecipeItem,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.check, size: 18),
                    label: Text(
                      widget.itemIndex != null ? 'Atualizar' : 'Adicionar',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
