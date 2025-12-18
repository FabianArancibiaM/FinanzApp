import '../models/movement.dart';

abstract class MovementsDAO {
  Future<int> insert(Movement movement);
  Future<List<Movement>> getAll();
  Future<List<Movement>> getByMonth(int year, int month);
  Future<List<Movement>> getByDateRange(DateTime startDate, DateTime endDate);
  Future<int> update(Movement movement);
  Future<int> delete(int id);
  Future<double> getTotalByMonth(int year, int month);
  Future<double> getIncomeByMonth(int year, int month);
  Future<double> getExpensesByMonth(int year, int month);
}

class InMemoryMovementsDAO extends MovementsDAO {
  final List<Movement> _movements = [];
  int _nextId = 1;

  @override
  Future<int> insert(Movement movement) async {
    final newMovement = movement.copyWith(id: _nextId);
    _movements.add(newMovement);
    return _nextId++;
  }

  @override
  Future<List<Movement>> getAll() async {
    final sortedMovements = List<Movement>.from(_movements);
    sortedMovements.sort((a, b) => b.date.compareTo(a.date));
    return sortedMovements;
  }

  @override
  Future<List<Movement>> getByMonth(int year, int month) async {
    return _movements.where((movement) {
      return movement.date.year == year && movement.date.month == month;
    }).toList();
  }

  @override
  Future<List<Movement>> getByDateRange(DateTime startDate, DateTime endDate) async {
    return _movements.where((movement) {
      return movement.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
             movement.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Future<int> update(Movement movement) async {
    final index = _movements.indexWhere((m) => m.id == movement.id);
    if (index != -1) {
      _movements[index] = movement;
      return 1;
    }
    return 0;
  }

  @override
  Future<int> delete(int id) async {
    final index = _movements.indexWhere((m) => m.id == id);
    if (index != -1) {
      _movements.removeAt(index);
      return 1;
    }
    return 0;
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
