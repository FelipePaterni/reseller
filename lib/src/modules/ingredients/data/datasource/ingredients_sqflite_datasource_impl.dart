import 'package:reseller/src/modules/ingredients/data/datasource/ingredients_datasource.dart';
import 'package:reseller/src/modules/ingredients/data/models/ingredient_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reseller/src/core/database/app_database.dart';
import 'package:reseller/src/core/database/models/ingredient_db.dart';
import 'package:uuid/uuid.dart';

/// Implementação do IngredientsDataSource usando SQLite via sqflite
///
/// Camada Data - Responsabilidade: Acesso persistente aos dados
/// - Implementa IngredientsDataSource
/// - Trabalha com IngredientModel (DTOs)
/// - Persiste em SQLite
/// - Pode ser substituído por API remota ou outro storage
class IngredientsSQLiteDataSourceImpl implements IngredientsDataSource {
  final AppDatabase database;

  IngredientsSQLiteDataSourceImpl({required this.database});

  @override
  Future<List<IngredientModel>> getAll() async {
    try {
      final db = await database.database;
      final maps = await db.query('ingredients', orderBy: 'name ASC');

      return maps.map((map) => IngredientDB.fromMap(map).toModel()).toList();
    } catch (e) {
      throw Exception('Erro ao recuperar ingredientes: $e');
    }
  }

  @override
  Future<IngredientModel> getById(String id) async {
    try {
      final db = await database.database;
      final maps = await db.query(
        'ingredients',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isEmpty) {
        throw Exception('Ingrediente com id $id não encontrado');
      }

      return IngredientDB.fromMap(maps.first).toModel();
    } catch (e) {
      throw Exception('Erro ao recuperar ingrediente: $e');
    }
  }

  @override
  Future<IngredientModel> save(IngredientModel ingredient) async {
    try {
      final db = await database.database;
      final id = ingredient.id?.isNotEmpty == true
          ? ingredient.id!
          : const Uuid().v4();

      final ingredientDB = IngredientDB.fromModel(ingredient).copyWith(id: id);

      // Verifica se já existe
      final existing = await db.query(
        'ingredients',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (existing.isNotEmpty) {
        // UPDATE
        await db.update(
          'ingredients',
          ingredientDB.toMap(),
          where: 'id = ?',
          whereArgs: [id],
        );
      } else {
        // INSERT
        await db.insert(
          'ingredients',
          ingredientDB.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      return ingredientDB.toModel();
    } catch (e) {
      throw Exception('Erro ao salvar ingrediente: $e');
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      final db = await database.database;
      await db.delete('ingredients', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Erro ao deletar ingrediente: $e');
    }
  }

  @override
  Future<int> count() async {
    try {
      final db = await database.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ingredients',
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw Exception('Erro ao contar ingredientes: $e');
    }
  }
}

/// Extension para facilitar cópia de IngredientDB com alguns campos alterados
extension IngredientDBCopyWith on IngredientDB {
  IngredientDB copyWith({
    String? id,
    String? name,
    String? unitLabel,
    double? quantity,
    double? totalCost,
    double? costPerUnit,
    String? createdAt,
    String? updatedAt,
  }) {
    return IngredientDB(
      id: id ?? this.id,
      name: name ?? this.name,
      unitLabel: unitLabel ?? this.unitLabel,
      quantity: quantity ?? this.quantity,
      totalCost: totalCost ?? this.totalCost,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
