import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/finance_service.dart';
import '../../core/utils/format.dart';
import '../../shared/widgets/movement_tile.dart';
import '../../shared/theme/app_theme.dart';

class MonthDetailScreen extends StatefulWidget {
  const MonthDetailScreen({super.key});

  @override
  State<MonthDetailScreen> createState() => _MonthDetailScreenState();
}

class _MonthDetailScreenState extends State<MonthDetailScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FormatUtils.formatMonthYear(_selectedDate)),
        actions: [
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _selectMonth,
          ),
        ],
      ),
      body: Consumer<FinanceService>(
        builder: (context, financeService, child) {
          final movements = financeService.getMovementsForMonth(
            _selectedDate.year,
            _selectedDate.month,
          );

          final monthlyIncome = movements
              .where((m) => m.isIncome)
              .fold(0.0, (sum, m) => sum + m.amount);

          final monthlyExpenses = movements
              .where((m) => m.isExpense)
              .fold(0.0, (sum, m) => sum + m.amount.abs());

          final monthlyBalance = monthlyIncome - monthlyExpenses;

          return Column(
            children: [
              // Monthly Summary
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: monthlyBalance >= 0
                      ? AppTheme.balanceGradient
                      : const LinearGradient(
                          colors: [AppTheme.balanceNegativeColor, Color(0xFFE57373)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.cardShadowColor,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Balance total',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      FormatUtils.formatCurrency(monthlyBalance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            'Ingresos',
                            monthlyIncome,
                            Icons.arrow_upward,
                            Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard(
                            'Gastos',
                            monthlyExpenses,
                            Icons.arrow_downward,
                            Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Movements List
              if (movements.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay movimientos este mes',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Los movimientos que agregues aparecerán aquí',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: movements.length,
                    itemBuilder: (context, index) {
                      final movement = movements[index];
                      return MovementTile(
                        movement: movement,
                        onLongPress: () => _showDeleteDialog(context, movement),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-movement'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            FormatUtils.formatCurrency(amount),
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showDeleteDialog(BuildContext context, movement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar movimiento'),
          content: Text(
            '¿Estás seguro de que quieres eliminar este movimiento de ${movement.category}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<FinanceService>().deleteMovement(movement.id!);
              },
              child: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
