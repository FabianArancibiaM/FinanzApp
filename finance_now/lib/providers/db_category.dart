import 'dart:io';

import 'package:finance_now/models/category_data_model.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBCategory {
  late Database _database;
  static final DBCategory db = DBCategory._();
  DBCategory._();

  Future<Database> get database async {
    return initDB();
  }

  Future<Database> initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'FinanceNowDB.db');
    final database = await openDatabase(
      path,
      version: 12, // Se tiene que cambiar siempre que cambie la base
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY,
            details TEXT,
          );
        ''');
      },
    );
    return database;
  }

  Future<List<CategoryDataModel>> getAllCategoryData() async {
    final db = await database;
    final res = await db.query('category');

    return res.isNotEmpty
        ? res.map((s) => CategoryDataModel.fromJson(s)).toList()
        : [];
  }

  Future<int> newCategory(CategoryDataModel nuevo) async {
    final db = await database;
    final res = await db.insert('category', nuevo.toJson());

    // Es el ID del último registro insertado;
    return res;
  }
}
