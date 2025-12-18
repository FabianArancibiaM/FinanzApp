import 'package:flutter/material.dart';
import '../../core/models/movement.dart';
import '../../core/utils/format.dart';
import '../theme/app_theme.dart';

class MovementTile extends StatelessWidget {
  final Movement movement;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MovementTile({
    super.key,
    required this.movement,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = movement.isIncome;
    final color = isIncome ? AppTheme.incomeColor : AppTheme.expenseColor;
    final icon = isIncome ? Icons.add_circle : Icons.remove_circle;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        title: Text(
          movement.category,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          FormatUtils.formatShortDate(movement.date),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              FormatUtils.formatCurrency(movement.absoluteAmount),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              isIncome ? 'Ingreso' : 'Gasto',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
