import 'package:flutter/material.dart';

//
// #6A32C5
// #0063ED
// #0081F8
// #0097E7
// #00A8C4
// #00B698

class AppTheme {
  static const Color primary = Color(0xFF6A32C5);

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: Color(0xFF0063ED),
          background: Color(0xFF00A8C4),
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light),
      primaryColor: primary,
      // AppBar theme
      appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
      scaffoldBackgroundColor: Colors.teal.shade100,

      // TextButton theme
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      // Estilos de botones
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary, elevation: 5),
      //
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: const StadiumBorder(),
              elevation: 0)),
      inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: primary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primary),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10)))));
}
