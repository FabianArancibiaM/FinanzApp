import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    colorScheme: const ColorScheme(
        primary: Color(0xFF123456),
        secondary: Color.fromARGB(255, 171, 213, 46),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
        secondaryFixed: Color(0xFFF39C12),
        primaryFixed: Color(0xFF2ecc71),
        tertiaryFixed: Color(0xFF2c3e50)),
  );
}
