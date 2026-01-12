/// Helper para calcular o custo unitário de um ingrediente.
///
/// Isola a lógica de negócio do widget, facilitando testes e reutilização.
class CostCalculator {
  /// Calcula o custo por unidade.
  ///
  /// Retorna 0 se a quantidade for inválida ou menor que 0.
  /// Caso contrário, retorna [totalCost] / [quantity].
  static double calculateUnitCost({
    required double quantity,
    required double totalCost,
  }) {
    if (quantity <= 0) {
      return 0;
    }
    return totalCost / quantity;
  }

  /// Valida se os valores de entrada são válidos.
  ///
  /// Retorna true se:
  /// - quantity é um número válido e maior que 0
  /// - totalCost é um número válido e maior ou igual a 0
  static bool isValidInput({
    required String quantityStr,
    required String totalCostStr,
  }) {
    final quantity = double.tryParse(quantityStr);
    final totalCost = double.tryParse(totalCostStr);

    return quantity != null &&
        quantity > 0 &&
        totalCost != null &&
        totalCost >= 0;
  }
}
