import 'package:sqflite/sqflite.dart';
import '../models/movement.dart';
import 'database.dart';
import 'web_movements_dao.dart';

class SqliteMovementsDAO extends MovementsDAO {
  final SqliteAppDatabase _database;
  
  SqliteMovementsDAO(this._database);

  @override
  Future<int> insert(Movement movement) async {
    final db = await _database.database;
    return await db.insert('movements', movement.toMap());
  }

  @override
  Future<List<Movement>> getAll() async {
    final db = await _database.database;
    final maps = await db.query('movements', orderBy: 'date DESC');
    
    return List.generate(maps.length, (i) {
      return Movement.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Movement>> getByMonth(int year, int month) async {
    final db = await _database.database;
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
    
    final maps = await db.query(
      'movements',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'date DESC',
    );
    
    return List.generate(maps.length, (i) {
      return Movement.fromMap(maps[i]);
    });
  }

  @override
  Future<List<Movement>> getByDateRange(DateTime startDate, DateTime endDate) async {
    final db = await _database.database;
    
    final maps = await db.query(
      'movements',
      where: 'date >= ? AND date <= ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'date DESC',
    );
    
    return List.generate(maps.length, (i) {
      return Movement.fromMap(maps[i]);
    });
  }

  @override
  Future<int> update(Movement movement) async {
    final db = await _database.database;
    return await db.update(
      'movements',
      movement.toMap(),
      where: 'id = ?',
      whereArgs: [movement.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    final db = await _database.database;
    return await db.delete(
      'movements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<double> getTotalByMonth(int year, int month) async {
    final movements = await getByMonth(year, month);
    double total = 0.0;
    for (final movement in movements) {
      total += movement.amount;
    }
    return total;
  }

  @override
  Future<double> getIncomeByMonth(int year, int month) async {
    final movements = await getByMonth(year, month);
    double total = 0.0;
    for (final movement in movements) {
      if (movement.isIncome) {
        total += movement.amount;
      }
    }
    return total;
  }

  @override
  Future<double> getExpensesByMonth(int year, int month) async {
    final movements = await getByMonth(year, month);
    double total = 0.0;
    for (final movement in movements) {
      if (movement.isExpense) {
        total += movement.amount.abs();
      }
    }
    return total;
  }
}
