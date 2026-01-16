import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/presentation/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/presentation/provider/recipes_provider.dart';
import 'package:reseller/src/modules/recipes/presentation/widgets/ingredient_total_recipe.dart';

class RecipeItemEditSheet extends StatefulWidget {
  final String recipeId;
  final RecipeItem? recipeItem;
  final int? itemIndex;
  final List<RecipeItem> currentItems;

  const RecipeItemEditSheet({
    super.key,
    required this.recipeId,
    this.recipeItem,
    this.itemIndex,
    this.currentItems = const [],
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
      _selectedIngredient = context.read<IngredientsProvider>().all.first;
      _quantity = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final allIngredients = context.read<IngredientsProvider>().all;

    // Get IDs of ingredients already in the recipe (excluding current one if editing)
    final usedIngredientIds = widget.currentItems
        .asMap()
        .entries
        .where((entry) => entry.key != widget.itemIndex)
        .map((entry) => entry.value.ingredient.id)
        .toSet();

    // Filter ingredients to show only those not yet added
    final availableIngredients = allIngredients
        .where((ingredient) => !usedIngredientIds.contains(ingredient.id))
        .toList();

    // Reset _selectedIngredient if it's no longer available
    if (!availableIngredients.contains(_selectedIngredient) &&
        availableIngredients.isNotEmpty) {
      setState(() => _selectedIngredient = availableIngredients.first);
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
    final allIngredients = context.watch<IngredientsProvider>().all;

    // Get IDs of ingredients already in the recipe (excluding current one if editing)
    final usedIngredientIds = widget.currentItems
        .asMap()
        .entries
        .where((entry) => entry.key != widget.itemIndex)
        .map((entry) => entry.value.ingredient.id)
        .toSet();

    // Filter ingredients to show only those not yet added
    final availableIngredients = allIngredients
        .where((ingredient) => !usedIngredientIds.contains(ingredient.id))
        .toList();

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
            if (availableIngredients.isEmpty)
              Center(
                child: Text(
                  'Todos os ingredientes já foram adicionados',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              FormBuilderDropdown<Ingredient>(
                name: 'ingredient_select',
                initialValue: availableIngredients.contains(_selectedIngredient)
                    ? _selectedIngredient
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Ingrediente',
                  hintText: 'Selecione um ingrediente',
                ),
                items: availableIngredients
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
            IngredientTotalRecipe(
              selectedIngredient: _selectedIngredient,
              theme: theme,
              quantity: _quantity,
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
                    onPressed: availableIngredients.isEmpty || _isLoading
                        ? null
                        : _saveRecipeItem,
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
