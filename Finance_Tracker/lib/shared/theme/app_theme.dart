import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF2E7D32);
  static const _errorColor = Color(0xFFD32F2F);
  static const _surfaceColor = Color(0xFFF8F9FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        brightness: Brightness.light,
        surface: _surfaceColor,
        error: _errorColor,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF212529),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF212529),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      scaffoldBackgroundColor: _surfaceColor,
    );
  }

  // Colores específicos para la app
  static const Color incomeColor = Color(0xFF4CAF50);
  static const Color expenseColor = Color(0xFFF44336);
  static const Color balancePositiveColor = Color(0xFF2E7D32);
  static const Color balanceNegativeColor = Color(0xFFD32F2F);
  static const Color neutralColor = Color(0xFF757575);
  static const Color cardShadowColor = Color(0x1A000000);

  // Gradientes
  static const LinearGradient incomeGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient expenseGradient = LinearGradient(
    colors: [Color(0xFFF44336), Color(0xFFEF5350)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient balanceGradient = LinearGradient(
    colors: [Color(0xFF2E7D32), Color(0xFF388E3C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
