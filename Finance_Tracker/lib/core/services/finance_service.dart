import 'package:flutter/material.dart';
import '../models/movement.dart';
import '../db/web_movements_dao.dart';

class FinanceService extends ChangeNotifier {
  late final MovementsDAO _movementsDAO;
  
  List<Movement> _movements = [];
  bool _isLoading = false;
  String? _error;

  FinanceService() {
    _movementsDAO = InMemoryMovementsDAO();
    _loadMovements();
  }

  // Getters
  List<Movement> get movements => _movements;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Cargar todos los movimientos
  Future<void> _loadMovements() async {
    _setLoading(true);
    try {
      _movements = await _movementsDAO.getAll();
      _error = null;
    } catch (e) {
      _error = 'Error al cargar movimientos: $e';
    } finally {
      _setLoading(false);
    }
  }

  // Agregar movimiento
  Future<bool> addMovement(Movement movement) async {
    _setLoading(true);
    try {
      final id = await _movementsDAO.insert(movement);
      if (id > 0) {
        await _loadMovements(); // Recargar la lista
        _error = null;
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al agregar movimiento: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Eliminar movimiento
  Future<bool> deleteMovement(int id) async {
    _setLoading(true);
    try {
      final result = await _movementsDAO.delete(id);
      if (result > 0) {
        await _loadMovements(); // Recargar la lista
        _error = null;
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Error al eliminar movimiento: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Obtener movimientos del mes actual
  List<Movement> getCurrentMonthMovements() {
    final now = DateTime.now();
    return getMovementsForMonth(now.year, now.month);
  }

  // Obtener movimientos de un mes específico
  List<Movement> getMovementsForMonth(int year, int month) {
    return _movements.where((movement) {
      return movement.date.year == year && movement.date.month == month;
    }).toList();
  }

  // Calcular balance del mes actual
  double getCurrentMonthBalance() {
    final movements = getCurrentMonthMovements();
    return movements.fold(0.0, (sum, movement) => sum + movement.amount);
  }

  // Calcular ingresos del mes actual
  double getCurrentMonthIncome() {
    final movements = getCurrentMonthMovements();
    return movements
        .where((m) => m.isIncome)
        .fold(0.0, (sum, movement) => sum + movement.amount);
  }

  // Calcular gastos del mes actual
  double getCurrentMonthExpenses() {
    final movements = getCurrentMonthMovements();
    return movements
        .where((m) => m.isExpense)
        .fold(0.0, (sum, movement) => sum + movement.amount.abs());
  }

  // Proyección de fin de mes (simple)
  double getMonthEndProjection() {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysPassed = now.day;
    final remainingDays = daysInMonth - daysPassed;

    if (remainingDays <= 0 || daysPassed == 0) {
      return getCurrentMonthBalance();
    }

    final currentExpenses = getCurrentMonthExpenses();
    final avgDailyExpenses = currentExpenses / daysPassed;
    final projectedRemainingExpenses = avgDailyExpenses * remainingDays;
    
    return getCurrentMonthBalance() - projectedRemainingExpenses;
  }

  // Obtener movimientos recientes
  List<Movement> getRecentMovements({int limit = 5}) {
    final sortedMovements = List<Movement>.from(_movements);
    sortedMovements.sort((a, b) => b.date.compareTo(a.date));
    return sortedMovements.take(limit).toList();
  }

  // Refrescar datos
  Future<void> refresh() async {
    await _loadMovements();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Limpiar error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
