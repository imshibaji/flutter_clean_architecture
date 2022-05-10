import 'package:clean_archetructure/config/app_colors.dart';
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
          primarySwatch: AppColors.teal,
          bottomAppBarColor: Colors.white,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: AppColors.teal,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.teal,
            selectedItemColor: Color.fromARGB(255, 248, 250, 250),
            elevation: 10,
            showSelectedLabels: true,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.teal),
        );

    dark = dark ??
        ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.yellow,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.space,
            selectedItemColor: AppColors.teal,
            elevation: 10,
            showSelectedLabels: true,
          ),
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
