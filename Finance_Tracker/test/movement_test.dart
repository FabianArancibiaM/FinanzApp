import 'package:flutter_test/flutter_test.dart';
import 'package:finance_tracker/core/models/movement.dart';

void main() {
  group('Movement Model Tests', () {
    test('should create movement with positive amount for income', () {
      final movement = Movement(
        amount: 100.0,
        category: 'Salario',
        date: DateTime(2023, 12, 1),
      );

      expect(movement.isIncome, true);
      expect(movement.isExpense, false);
      expect(movement.absoluteAmount, 100.0);
    });

    test('should create movement with negative amount for expense', () {
      final movement = Movement(
        amount: -50.0,
        category: 'Alimentación',
        date: DateTime(2023, 12, 1),
      );

      expect(movement.isIncome, false);
      expect(movement.isExpense, true);
      expect(movement.absoluteAmount, 50.0);
    });

    test('should convert movement to map correctly', () {
      final movement = Movement(
        id: 1,
        amount: 100.0,
        category: 'Salario',
        date: DateTime(2023, 12, 1),
      );

      final map = movement.toMap();

      expect(map['id'], 1);
      expect(map['amount'], 100.0);
      expect(map['category'], 'Salario');
      expect(map['date'], '2023-12-01T00:00:00.000');
    });

    test('should create movement from map correctly', () {
      final map = {
        'id': 1,
        'amount': 100.0,
        'category': 'Salario',
        'date': '2023-12-01T00:00:00.000',
      };

      final movement = Movement.fromMap(map);

      expect(movement.id, 1);
      expect(movement.amount, 100.0);
      expect(movement.category, 'Salario');
      expect(movement.date, DateTime(2023, 12, 1));
    });
  });
}
