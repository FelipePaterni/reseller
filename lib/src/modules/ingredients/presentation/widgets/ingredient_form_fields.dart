import 'package:flutter/material.dart';

/// Widget que encapsula os campos de entrada do formulário de ingrediente.
///
/// Responsabilidades:
/// - Exibir campos de nome, quantidade, unidade e custo total
/// - Delegar callbacks para mudanças de valor
/// - Gerenciar próprios controladores de texto
class IngredientFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController totalCostController;
  final String selectedUnit;
  final ValueChanged<String> onUnitChanged;
  final VoidCallback onQuantityOrCostChanged;

  static const List<String> unitOptions = <String>['kg', 'g', 'un', 'ml', 'l'];

  const IngredientFormFields({
    super.key,
    required this.nameController,
    required this.quantityController,
    required this.totalCostController,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.onQuantityOrCostChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo: Nome do ingrediente
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Nome do ingrediente',
            hintText: 'Ex: Chocolate em Pó',
          ),
        ),
        const SizedBox(height: 16),

        // Linha: Quantidade + Unidade
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: quantityController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => onQuantityOrCostChanged(),
                decoration: const InputDecoration(
                  labelText: 'Quantidade comprada',
                  hintText: '0',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: selectedUnit,
                decoration: const InputDecoration(
                  labelText: 'Unidade de medida',
                ),
                items: unitOptions
                    .map(
                      (unit) => DropdownMenuItem<String>(
                        value: unit,
                        child: Text(unit.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    onUnitChanged(value);
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Campo: Preço total
        TextField(
          controller: totalCostController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => onQuantityOrCostChanged(),
          decoration: const InputDecoration(
            labelText: 'Preço total da compra',
            hintText: "R\$ 0,00",
          ),
        ),
      ],
    );
  }
}
