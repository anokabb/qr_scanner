import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightThemeData = ThemeData(
    primaryColor: Color.fromRGBO(98, 0, 238, 1),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromRGBO(98, 0, 238, 1),
        brightness: Brightness.light),
    backgroundColor: Colors.white,
    splashColor: Colors.black,
    buttonColor: Colors.white,
    canvasColor: Color(0xFFF2F2F2),
    highlightColor: Colors.grey.withOpacity(0.5),
  );

  static final ThemeData darkThemeData = ThemeData(
    primaryColor: Color.fromRGBO(255, 2, 102, 1),
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromRGBO(44, 44, 44, 1),
        brightness: Brightness.light),
    backgroundColor: Colors.black,
    splashColor: Colors.white,
    buttonColor: Color.fromRGBO(44, 44, 44, 1),
    canvasColor: Color.fromRGBO(44, 44, 44, 1),
    highlightColor: Colors.grey.withOpacity(0.5),
  );
}
