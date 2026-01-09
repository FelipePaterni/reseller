import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredients.dart';

class IngredientEditSheet extends StatefulWidget {
  final Ingredient ingredient;

  const IngredientEditSheet({super.key, required this.ingredient});

  @override
  State<IngredientEditSheet> createState() => _IngredientEditSheetState();
}

class _IngredientEditSheetState extends State<IngredientEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _totalCostController;

  late String _selectedUnit;
  late double _calculatedUnitCost;

  static const List<String> _unitOptions = <String>['kg', 'g', 'un', 'ml', 'l'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.ingredient.title);
    _quantityController = TextEditingController(
      text: widget.ingredient.quantity.toString(),
    );
    _totalCostController = TextEditingController(
      text: widget.ingredient.totalCost.toStringAsFixed(2),
    );
    _selectedUnit = widget.ingredient.costPerUnitLabel;
    _calculatedUnitCost = widget.ingredient.costPerUnit;

    _quantityController.addListener(_recalculateUnitCost);
    _totalCostController.addListener(_recalculateUnitCost);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _totalCostController.dispose();
    super.dispose();
  }

  void _recalculateUnitCost() {
    final double quantity = double.tryParse(_quantityController.text) ?? 0;
    final double totalCost = double.tryParse(_totalCostController.text) ?? 0;

    if (quantity <= 0) {
      setState(() => _calculatedUnitCost = 0);
      return;
    }

    setState(() => _calculatedUnitCost = totalCost / quantity);
  }

  void _onSave() {
    final updated = Ingredient(
      id: widget.ingredient.id,
      title: _nameController.text.trim().isEmpty
          ? widget.ingredient.title
          : _nameController.text.trim(),
      quantity:
          double.tryParse(_quantityController.text) ??
          widget.ingredient.quantity,
      totalCost:
          double.tryParse(_totalCostController.text) ??
          widget.ingredient.totalCost,
      costPerUnitLabel: _selectedUnit,
      costPerUnit: _calculatedUnitCost > 0
          ? _calculatedUnitCost
          : widget.ingredient.costPerUnit,
    );

    Navigator.of(context).pop(updated);
  }

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Editar Ingrediente',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(Icons.close, color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome do ingrediente',
              hintText: 'Ex: Chocolate em Pó',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _quantityController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Quantidade comprada',
                    hintText: '0',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedUnit,
                  decoration: const InputDecoration(
                    labelText: 'Unidade de medida',
                  ),
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
                    setState(() => _selectedUnit = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _totalCostController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Preço total da compra',
              hintText: "R\$ 0,00",
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Custo calculado:',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'CUSTO POR UNIDADE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'R\$ ${_calculatedUnitCost.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/ $_selectedUnit',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: _onSave,
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
    );
  }
}
