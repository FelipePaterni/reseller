import 'package:flutter_test/flutter_test.dart';
import 'package:reseller/src/modules/ingredients/presentation/widgets/cost_calculator.dart';

void main() {
  group('CostCalculator', () {
    group('calculateUnitCost', () {
      test('calcula corretamente o custo por unidade', () {
        final result = CostCalculator.calculateUnitCost(
          quantity: 10,
          totalCost: 50,
        );
        expect(result, 5.0);
      });

      test('retorna 0 quando quantidade é zero', () {
        final result = CostCalculator.calculateUnitCost(
          quantity: 0,
          totalCost: 50,
        );
        expect(result, 0);
      });

      test('retorna 0 quando quantidade é negativa', () {
        final result = CostCalculator.calculateUnitCost(
          quantity: -10,
          totalCost: 50,
        );
        expect(result, 0);
      });

      test('calcula corretamente com valores decimais', () {
        final result = CostCalculator.calculateUnitCost(
          quantity: 2.5,
          totalCost: 12.5,
        );
        expect(result, 5.0);
      });

      test('retorna 0 quando custo é 0', () {
        final result = CostCalculator.calculateUnitCost(
          quantity: 10,
          totalCost: 0,
        );
        expect(result, 0);
      });
    });

    group('isValidInput', () {
      test('retorna true para inputs válidos', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '10',
          totalCostStr: '50',
        );
        expect(result, true);
      });

      test('retorna true com números decimais', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '10.5',
          totalCostStr: '50.75',
        );
        expect(result, true);
      });

      test('retorna false quando quantidade é zero', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '0',
          totalCostStr: '50',
        );
        expect(result, false);
      });

      test('retorna false quando quantidade é negativa', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '-10',
          totalCostStr: '50',
        );
        expect(result, false);
      });

      test('retorna false quando quantidade é inválida', () {
        final result = CostCalculator.isValidInput(
          quantityStr: 'abc',
          totalCostStr: '50',
        );
        expect(result, false);
      });

      test('retorna false quando custo total é inválido', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '10',
          totalCostStr: 'xyz',
        );
        expect(result, false);
      });

      test('retorna false quando custo é negativo', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '10',
          totalCostStr: '-50',
        );
        expect(result, false);
      });

      test('retorna true quando custo é zero (válido)', () {
        final result = CostCalculator.isValidInput(
          quantityStr: '10',
          totalCostStr: '0',
        );
        expect(result, true);
      });
    });
  });
}
