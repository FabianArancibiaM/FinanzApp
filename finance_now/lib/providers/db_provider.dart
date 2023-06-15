import 'dart:io';

import 'package:finance_now/models/financial_data_model.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  late Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

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
          CREATE TABLE financialMovement (
            id INTEGER PRIMARY KEY,
            details TEXT,
            periodNumber INTEGER,
            ammount INTEGER,
            type TEXT,
            category TEXT,
            dateOperation TEXT
          );
        ''');
      },
    );
    return database;
  }

  Future<int> nuevoMovement(FinancialDataModel nuevo) async {
    final db = await database;
    final res = await db.insert('financialMovement', nuevo.toJson());

    // Es el ID del último registro insertado;
    return res;
  }

  Future<List<FinancialDataModel>> getAllFinancialData() async {
    final db = await database;
    final res = await db.query('financialMovement');

    return res.isNotEmpty
        ? res.map((s) => FinancialDataModel.fromJson(s)).toList()
        : [];
  }

  Future<List<FinancialDataModel>> getDataToPeriod(int period) async {
    final db = await database;
    final res = await db.query('financialMovement',
        where: 'periodNumber = ?', whereArgs: [period]);

    return res.isNotEmpty
        ? res.map((s) => FinancialDataModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateMovement(FinancialDataModel nuevo) async {
    final db = await database;
    final res = await db.update('financialMovement', nuevo.toJson(),
        where: 'id = ?', whereArgs: [nuevo.id]);
    return res;
  }

  Future<int> deleteMovement(int id) async {
    final db = await database;
    final res =
        await db.delete('financialMovement', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<FinancialDataModel?> getFinancialMovementWithMaxPeriodNumber() async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT * FROM financialMovement ORDER BY periodNumber DESC LIMIT 1');

    if (result.isNotEmpty) {
      return result.map((s) => FinancialDataModel.fromJson(s)).toList().first;
    } else {
      return null; // Retorna un mapa vacío si no se encuentran registros
    }
  }
}
