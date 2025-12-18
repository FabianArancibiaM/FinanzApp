import 'package:intl/intl.dart';

class FormatUtils {
  static final _currencyFormatter = NumberFormat.currency(
    locale: 'es',
    symbol: '\$ ',
    decimalDigits: 0,
  );

  static final _dateFormatter = DateFormat('dd/MM/yyyy');
  static final _monthYearFormatter = DateFormat('MMMM yyyy', 'es');
  static final _shortDateFormatter = DateFormat('dd MMM', 'es');

  static String formatCurrency(double amount) {
    // Formatear manualmente para asegurar el formato chileno $ 100.000
    final absAmount = amount.abs();
    final formatter = NumberFormat('#,###', 'es');
    final formattedNumber = formatter.format(absAmount).replaceAll(',', '.');
    final prefix = amount >= 0 ? '\$ ' : '-\$ ';
    return '$prefix$formattedNumber';
  }

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  static String formatMonthYear(DateTime date) {
    return _monthYearFormatter.format(date);
  }

  static String formatShortDate(DateTime date) {
    return _shortDateFormatter.format(date);
  }

  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }

  static String getMonthName(int month) {
    final date = DateTime(2023, month, 1);
    return DateFormat('MMMM', 'es').format(date);
  }

  static String formatCompactCurrency(double amount) {
    if (amount.abs() >= 1000000) {
      return '\$ ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount.abs() >= 1000) {
      return '\$ ${(amount / 1000).toStringAsFixed(1)}k';
    } else {
      return formatCurrency(amount);
    }
  }

  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  static double getDaysPassed(DateTime date) {
    final now = DateTime.now();
    final startOfMonth = DateTime(date.year, date.month, 1);
    final daysPassed = now.difference(startOfMonth).inDays + 1;
    return daysPassed.toDouble();
  }
}
