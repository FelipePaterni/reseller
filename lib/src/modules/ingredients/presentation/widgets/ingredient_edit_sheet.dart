import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:provider/provider.dart';
import 'package:reseller/src/modules/ingredients/data/provider/ingredients_provider.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/calculated_cost_display.dart';

class IngredientEditSheet extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientEditSheet({super.key, required this.ingredient});

  @override
  State<IngredientEditSheet> createState() => _IngredientEditSheetState();
}

class _IngredientEditSheetState extends State<IngredientEditSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  //  final Map<String, dynamic> _formData = {};
  static const List<String> _unitOptions = <String>['kg', 'g', 'un', 'ml', 'l'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  widget.ingredient.id != null
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
            FormBuilderTextField(
              name: 'ingredient_name',
              initialValue: widget.ingredient.name,
              decoration: const InputDecoration(
                labelText: 'Nome do ingrediente',
                hintText: 'Ex: Chocolate em Pó',
              ),
              onChanged: (value) =>
                  setState(() => widget.ingredient.name = value ?? ''),
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  flex: 3,
                  child: FormBuilderTextField(
                    name: 'ingredient_quantity',
                    initialValue: widget.ingredient.quantity.toString(),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade comprada',
                    ),
                    onChanged: (value) => setState(
                      () => widget.ingredient.quantity =
                          double.tryParse(value ?? '') ?? 0.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FormBuilderDropdown<String>(
                    name: 'ingredient_unit',
                    initialValue: widget.ingredient.unitLabel,
                    decoration: const InputDecoration(labelText: 'Unidade'),
                    items: _unitOptions
                        .map(
                          (unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => widget.ingredient.unitLabel = value);
                    },
                  ),
                ),
              ],
            ),
            FormBuilderTextField(
              name: 'ingredient_total_cost',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Preço total da compra',
                hintText: "R\$ 0,00",
              ),
              initialValue: widget.ingredient.totalCost.toString(),
              onChanged: (value) => setState(
                () => widget.ingredient.totalCost =
                    double.tryParse(value ?? '') ?? 0.0,
              ),
            ),
            CalculatedCostDisplay(
              costPerUnit: widget.ingredient.costPerUnit,
              unitLabel: widget.ingredient.unitLabel,
            ),
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Cancelar'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      final isValid =
                          _formKey.currentState?.saveAndValidate() ?? false;
                      if (isValid) {
                        Provider.of<IngredientsProvider>(
                          context,
                          listen: false,
                        ).createOrUpdate(widget.ingredient);
                        Navigator.of(context).maybePop();
                      }
                    },
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Atualizar'),
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
