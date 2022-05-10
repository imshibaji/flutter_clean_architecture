import 'package:flutter/material.dart';

class AppTheme {
  ThemeData? light;
  ThemeData? dark;

  AppTheme([
    this.light,
    this.dark,
  ]) {
    light = light ??
        ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.cyan,
            bottomAppBarColor: Colors.white,
            appBarTheme: const AppBarTheme(
                titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            )));

    dark = dark ??
        ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
        );
  }

  ThemeData get lightTheme => light!;
  ThemeData get darkTheme => dark!;

  AppTheme copyWith({
    ThemeData? light,
    ThemeData? dark,
  }) {
    return AppTheme(
      light ?? this.light,
      dark ?? this.dark,
    );
  }
}
