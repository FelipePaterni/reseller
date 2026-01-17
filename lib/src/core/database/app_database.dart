import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Gerenciador de banco de dados SQLite para Reseller App
///
/// Responsabilidades:
/// - Inicializar e gerenciar conexão com banco
/// - Criar e versionarschema
/// - Fornecer instância de Database para DataSources
///
/// Singleton pattern: AppDatabase() retorna sempre mesma instância
class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  Database? _database;

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  /// Getter para acessar banco de dados
  /// Inicializa automaticamente se não existir
  Future<Database> get database async {
    _database ??= await _initDatabase('app_database.db');
    return _database!;
  }

  /// Inicializa o banco de dados com schema
  Future<Database> _initDatabase(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  /// Cria todas as tabelas na primeira execução
  Future<void> _createTables(Database db, int version) async {
    await _createIngredientsTable(db);
    await _createRecipesTable(db);
    await _createRecipeItemsTable(db);
  }

  /// Cria tabela de ingredientes
  Future<void> _createIngredientsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ingredients(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        unit_label TEXT NOT NULL,
        quantity REAL NOT NULL,
        total_cost REAL NOT NULL,
        cost_per_unit REAL NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  /// Cria tabela de receitas
  Future<void> _createRecipesTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS recipes(
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        yield_recipe REAL NOT NULL,
        image_path TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  /// Cria tabela de itens de receita (relacionamento N:M)
  Future<void> _createRecipeItemsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS recipe_items(
        id TEXT PRIMARY KEY,
        recipe_id TEXT NOT NULL,
        ingredient_id TEXT NOT NULL,
        ingredient_name TEXT NOT NULL,
        cost_per_unit REAL NOT NULL,
        quantity REAL NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY(recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
      )
    ''');
  }

  /// Handle para migração de schema em versões futuras
  Future<void> _upgradeTables(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Implementar alterações de schema conforme necessário
    // Ex: if (oldVersion < 2) { ... }
  }

  /// Fechar banco de dados (chamar ao finalizar app)
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
