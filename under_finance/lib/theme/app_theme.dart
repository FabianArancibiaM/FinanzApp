import 'package:flutter/material.dart';

//
// #6A32C5
// #0063ED
// #0081F8
// #0097E7
// #00A8C4
// #00B698

class AppTheme {
  static const Color verde = Color.fromRGBO(29, 221, 186, 1);
  static const Color blanco = Color.fromRGBO(255, 255, 255, 1);
  static const Color amarillo = Color.fromRGBO(255, 255, 128, 1.0);
  static const Color azul = Color.fromRGBO(0, 0, 102, 1.0);

  static const Color primary = verde;
  static const Color secondary = azul;
  static const Color backgroundColor = blanco;
  static const Color accentColor = blanco;

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        background: backgroundColor,
        surface: Color.fromARGB(255, 181, 63, 148),
        error: Colors.red,
        onPrimary: Colors.black87,
        onSecondary: Colors.purpleAccent,
        onBackground: Color.fromARGB(255, 153, 30, 30),
        onSurface: Colors.black,
        onError: Colors.red,
        brightness: Brightness.light),
    primaryColor: primary,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: accentColor,
        selectedLabelStyle: TextStyle(color: Color.fromARGB(255, 68, 255, 71))),
    // AppBar theme
    appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
    scaffoldBackgroundColor: backgroundColor,

    // TextButton theme
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary)),
    // Estilos de botones
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary, elevation: 5),
    //
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 175, 159, 95),
            shape: const StadiumBorder(),
            elevation: 0)),
    // inputDecorationTheme: const InputDecorationTheme(
    //     floatingLabelStyle: TextStyle(color: primary),
    //     enabledBorder: OutlineInputBorder(
    //         borderSide: BorderSide(color: primary),
    //         borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(10),
    //             topRight: Radius.circular(10))),
    //     focusedBorder: OutlineInputBorder(
    //       borderSide: BorderSide(color: primary),
    //       borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
    //     ),
    //     border: OutlineInputBorder(
    //         borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(10),
    //             topRight: Radius.circular(10)))
    //             )
  );
}
