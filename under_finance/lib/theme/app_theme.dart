import 'package:flutter/material.dart';

//
// #6A32C5
// #0063ED
// #0081F8
// #0097E7
// #00A8C4
// #00B698

class AppTheme {
  static const Color primary = Color.fromRGBO(38, 251, 212, 1);
  static const Color accentColor = Color.fromRGBO(30, 37, 46, 1);
  static const Color backgroundColor = Color.fromRGBO(21, 25, 32, 1);
  static const Color textColor = Color.fromRGBO(38, 251, 212, 1);

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: Color.fromRGBO(21, 25, 32, 1),
        background: Color.fromRGBO(30, 37, 46, 1),
        surface: Color.fromARGB(255, 181, 63, 148),
        error: Colors.red,
        onPrimary: Colors.tealAccent,
        onSecondary: Colors.purpleAccent,
        onBackground: Colors.black,
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
