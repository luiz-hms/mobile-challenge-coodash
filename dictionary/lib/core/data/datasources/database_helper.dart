import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  static const String dbName = 'palavras.db';
  static const String tableName = 'palavras';

  static const String columnId = 'id';
  static const String columnPalavra = 'palavra';
  static const String columnFavorito = 'favorito';
  static const String columnHistorico = 'historico';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnPalavra TEXT,
        $columnFavorito INTEGER DEFAULT 0,
        $columnHistorico INTEGER DEFAULT 1
      );
    ''');
  }

  Future<int> insert(String palavra) async {
    final db = await database;
    return await db.insert(tableName, {
      columnPalavra: palavra,
      columnFavorito: 0,
      columnHistorico: 1,
    });
  }

  Future<int> update(String row, bool status) async {
    final db = await database;
    return await db.update(
      tableName,
      {
        row: status ? 1 : 0,
      },
      where: '$columnPalavra = ?',
      whereArgs: [
        [columnPalavra]
      ],
    );
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> queryByColumn(
      String column, int value) async {
    final db = await database;
    return await db.query(
      tableName,
      where: '$column = ?',
      whereArgs: [value],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
