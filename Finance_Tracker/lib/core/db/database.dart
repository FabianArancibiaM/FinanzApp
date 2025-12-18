import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'web_database.dart';

class SqliteAppDatabase implements AppDatabase {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('finance_tracker.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDir.path, filePath);
    
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movements(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  @override
  Future<void> init() async {
    await database;
  }

  @override
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
