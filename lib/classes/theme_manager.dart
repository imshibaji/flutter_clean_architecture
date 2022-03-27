import 'package:flutter/material.dart';

class ThemeManager {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.cyan,
  );
  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.yellow,
  );
}
