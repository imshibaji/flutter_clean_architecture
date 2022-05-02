import 'package:flutter/material.dart';

class ThemeManager {
  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.cyan,
      bottomAppBarColor: Colors.white,
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      )));
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.yellow,
  );
}
