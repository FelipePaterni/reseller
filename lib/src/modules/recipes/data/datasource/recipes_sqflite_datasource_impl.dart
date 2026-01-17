import 'package:reseller/src/modules/recipes/data/datasource/recipes_datasource.dart';
import 'package:reseller/src/modules/recipes/data/models/recipe_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reseller/src/core/database/app_database.dart';
import 'package:reseller/src/core/database/models/recipe_db.dart';
import 'package:uuid/uuid.dart';

/// Implementação do RecipesDataSource usando SQLite via sqflite
///
/// Camada Data - Responsabilidade: Acesso persistente aos dados
/// - Implementa RecipesDataSource
/// - Trabalha com RecipeModel (DTOs)
/// - Persiste em SQLite com relacionamento N:M (recipe_items)
/// - Pode ser substituído por API remota ou outro storage
class RecipesSQLiteDataSourceImpl implements RecipesDataSource {
  final AppDatabase database;

  RecipesSQLiteDataSourceImpl({required this.database});

  @override
  Future<List<RecipeModel>> getAll() async {
    try {
      final db = await database.database;
      final maps = await db.query('recipes', orderBy: 'name ASC');

      final recipes = <RecipeModel>[];
      for (final map in maps) {
        final recipe = RecipeDB.fromMap(map);
        final items = await _getRecipeItems(db, recipe.id);
        recipes.add(recipe.toModel(items: items));
      }

      return recipes;
    } catch (e) {
      throw Exception('Erro ao recuperar receitas: $e');
    }
  }

  @override
  Future<RecipeModel> getById(String id) async {
    try {
      final db = await database.database;
      final maps = await db.query('recipes', where: 'id = ?', whereArgs: [id]);

      if (maps.isEmpty) {
        throw Exception('Receita com id $id não encontrada');
      }

      final recipe = RecipeDB.fromMap(maps.first);
      final items = await _getRecipeItems(db, recipe.id);

      return recipe.toModel(items: items);
    } catch (e) {
      throw Exception('Erro ao recuperar receita: $e');
    }
  }

  @override
  Future<RecipeModel> save(RecipeModel recipe) async {
    try {
      final db = await database.database;
      final id = recipe.id?.isNotEmpty == true ? recipe.id! : const Uuid().v4();

      final recipeDB = RecipeDB.fromModel(recipe).copyWith(id: id);

      // Verifica se já existe
      final existing = await db.query(
        'recipes',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (existing.isNotEmpty) {
        // UPDATE receita
        await db.update(
          'recipes',
          recipeDB.toMap(),
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        // INSERT receita
        await db.insert(
          'recipes',
          recipeDB.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // Salvar itens da receita
      await _deleteRecipeItems(db, id);
      for (final item in recipe.items) {
        final itemDB = RecipeItemDB.fromModel(id, item);
        await db.insert(
          'recipe_items',
          itemDB.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return recipeDB.toModel(items: recipe.items);
    } catch (e) {
      throw Exception('Erro ao salvar receita: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final db = await database.database;

      // Deletar itens primeiro (foreign key)
      await _deleteRecipeItems(db, id);

      // Deletar receita
      await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Erro ao deletar receita: $e');
    }
  }

  @override
  Future<int> count() async {
    try {
      final db = await database.database;
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM recipes');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw Exception('Erro ao contar receitas: $e');
    }
  }

  /// Carrega itens de uma receita do banco
  Future<List<RecipeItemModel>> _getRecipeItems(
    Database db,
    String recipeId,
  ) async {
    final maps = await db.query(
      'recipe_items',
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
      orderBy: 'created_at ASC',
    );

    return maps.map((map) => RecipeItemDB.fromMap(map).toModel()).toList();
  }

  /// Deleta todos os itens de uma receita
  Future<void> _deleteRecipeItems(Database db, String recipeId) async {
    await db.delete(
      'recipe_items',
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
    );
  }
}

/// Extension para facilitar cópia de RecipeDB com alguns campos alterados
extension RecipeDBCopyWith on RecipeDB {
  RecipeDB copyWith({
    String? id,
    String? name,
    double? yieldRecipe,
    String? imagePath,
    String? createdAt,
    String? updatedAt,
  }) {
    return RecipeDB(
      id: id ?? this.id,
      name: name ?? this.name,
      yieldRecipe: yieldRecipe ?? this.yieldRecipe,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
