import 'package:flutter/material.dart';
import 'package:reseller/src/modules/recipes/domain/entities/recipe.dart';
import 'package:reseller/src/modules/recipes/domain/repositories/recipes_repository.dart';

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
class RecipesProvider with ChangeNotifier {
  final RecipesRepository repository;

  // Estado privado
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String? _error;

  RecipesProvider(this.repository);

  // Getters públicos para estado
  List<Recipe> get all => _recipes;
  int get count => _recipes.length;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carrega todas as receitas do repositório
  Future<void> load() async {
    _setLoading(true);
    _clearError();

    try {
      _recipes = await repository.getAll();
    } on Exception catch (e) {
      _setError('Erro ao carregar receitas: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Obtém receita por ID
  /// Retorna null se não encontrada
  Recipe? getById(String id) {
    try {
      return _recipes.firstWhere((recipe) => recipe.id == id);
    } on StateError {
      return null;
    }
  }

  /// Obtém receita por índice na lista
  Recipe? getByIndex(int index) {
    if (index < 0 || index >= _recipes.length) {
      return null;
    }
    return _recipes[index];
  }

  /// Cria ou atualiza uma receita
  Future<void> createOrUpdate(Recipe recipe) async {
    _setLoading(true);
    _clearError();

    try {
      await repository.save(recipe);
      await load();
    } on Exception catch (e) {
      _setError('Erro ao salvar receita: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Deleta receita por ID
  Future<void> deleteById(String id) async {
    _setLoading(true);
    _clearError();

    try {
      await repository.delete(id);
      await load();
    } on Exception catch (e) {
      _setError('Erro ao deletar receita: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  /// Deleta receita pelo objeto
  Future<void> deleteByObject(Recipe recipe) async {
    if (recipe.id == null || recipe.id!.isEmpty) {
      _setError('Receita inválida para deletar');
      return;
    }
    await deleteById(recipe.id!);
  }

  /// Adiciona item a uma receita
  Future<void> addRecipeItem(String recipeId, RecipeItem item) async {
    final recipe = getById(recipeId);
    if (recipe == null) {
      _setError('Receita não encontrada');
      return;
    }

    final updatedItems = [...recipe.items, item];
    final updatedRecipe = recipe.copyWith(items: updatedItems);
    await createOrUpdate(updatedRecipe);
  }

  /// Atualiza item de uma receita
  Future<void> updateRecipeItem(
    String recipeId,
    int itemIndex,
    RecipeItem newItem,
  ) async {
    final recipe = getById(recipeId);
    if (recipe == null) {
      _setError('Receita não encontrada');
      return;
    }

    final updatedItems = [...recipe.items];
    if (itemIndex >= 0 && itemIndex < updatedItems.length) {
      updatedItems[itemIndex] = newItem;
      final updatedRecipe = recipe.copyWith(items: updatedItems);
      await createOrUpdate(updatedRecipe);
    }
  }

  /// Remove item de uma receita
  Future<void> removeRecipeItem(String recipeId, int itemIndex) async {
    final recipe = getById(recipeId);
    if (recipe == null) {
      _setError('Receita não encontrada');
      return;
    }

    final updatedItems = [...recipe.items];
    if (itemIndex >= 0 && itemIndex < updatedItems.length) {
      updatedItems.removeAt(itemIndex);
      final updatedRecipe = recipe.copyWith(items: updatedItems);
      await createOrUpdate(updatedRecipe);
    }
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
