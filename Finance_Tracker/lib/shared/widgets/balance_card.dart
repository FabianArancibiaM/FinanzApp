import 'package:flutter/material.dart';
import '../../core/utils/format.dart';
import '../theme/app_theme.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;
  final double projection;
  final VoidCallback? onTap;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
    required this.projection,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = balance >= 0;
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: isPositive 
                ? AppTheme.balanceGradient 
                : const LinearGradient(
                    colors: [AppTheme.balanceNegativeColor, Color(0xFFE57373)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Balance del mes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    isPositive ? Icons.trending_up : Icons.trending_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                FormatUtils.formatCurrency(balance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryItem(
                      'Ingresos',
                      income,
                      Icons.arrow_upward,
                      Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSummaryItem(
                      'Gastos',
                      expenses,
                      Icons.arrow_downward,
                      Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white30),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Proyección fin de mes:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    FormatUtils.formatCurrency(projection),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          FormatUtils.formatCurrency(amount),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
