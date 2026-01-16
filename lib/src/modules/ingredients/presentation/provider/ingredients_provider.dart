import 'package:flutter/material.dart';
import 'package:reseller/src/modules/ingredients/domain/entities/ingredient.dart';
import 'package:reseller/src/modules/ingredients/domain/repositories/ingredients_repository.dart';

/// State Manager (Provider/ChangeNotifier)
///
/// Camada Presentation - Responsabilidade: Gerenciar estado da UI
/// ✅ O que DEVE fazer:
/// - Manter estado dos widgets (loading, error, data)
/// - Chamar casos de uso/serviços da camada Domain
/// - Notificar listeners quando estado muda
/// - Não contém lógica de negócio complexa
///
/// ❌ O que NÃO DEVE fazer:
/// - Acessar DataSource ou banco de dados diretamente
/// - Fazer validações de regra de negócio
/// - Gerenciar UI ou widgets
/// - Lidar com serialização/deserialização de dados
///
/// Fluxo: Widget → Provider → Repository → DataSource
class IngredientsProvider with ChangeNotifier {
  final IngredientsRepository repository;

  // Estado privado
  List<Ingredient> _ingredients = [];
  bool _isLoading = false;
  String? _error;

  IngredientsProvider(this.repository);

  // Getters públicos para estado
  List<Ingredient> get all => _ingredients;
  int get count => _ingredients.length;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todos os ingredientes do repositório
  Future<void> load() async {
    _setLoading(true);
    _clearError();

    try {
      _ingredients = await repository.getAll();
    } on Exception catch (e) {
      _setError('Erro ao carregar ingredientes: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Obtém ingrediente por ID
  /// Retorna null se não encontrado
  Ingredient? getById(String id) {
    try {
      return _ingredients.firstWhere((ingredient) => ingredient.id == id);
    } on StateError {
      return null;
    }
  }

  /// Obtém ingrediente por índice na lista
  Ingredient? getByIndex(int index) {
    if (index < 0 || index >= _ingredients.length) {
      return null;
    }
    return _ingredients[index];
  }

  /// Cria ou atualiza um ingrediente
  Future<void> createOrUpdate(Ingredient ingredient) async {
    _setLoading(true);
    _clearError();

    try {
      await repository.save(ingredient);
      await load();
    } on Exception catch (e) {
      _setError('Erro ao salvar ingrediente: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Deleta ingrediente por ID
  Future<void> deleteById(String id) async {
    _setLoading(true);
    _clearError();

    try {
      await repository.delete(id);
      await load();
    } on Exception catch (e) {
      _setError('Erro ao deletar ingrediente: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Deleta ingrediente pelo objeto
  Future<void> deleteByObject(Ingredient ingredient) async {
    if (ingredient.id == null || ingredient.id!.isEmpty) {
      _setError('Ingrediente inválido para deletar');
      return;
    }
    await deleteById(ingredient.id!);
  }

  // Helpers privados
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}
