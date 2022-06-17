import 'package:flutter/material.dart';

import '../../config/config.dart';

class AppTheme {
  ThemeData? light;
  ThemeData? dark;

  AppTheme([
    this.light,
    this.dark,
  ]) {
    setupTheme();
  }

  setupTheme() {
    light = ThemeData(
      brightness: Brightness.light,
      primarySwatch: AppColors.teal,
      bottomAppBarColor: Colors.white,
      scaffoldBackgroundColor: const Color.fromARGB(255, 222, 255, 252),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.teal,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.teal,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color.fromARGB(255, 11, 238, 250),
        elevation: 15,
        enableFeedback: true,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 213, 247, 249),
        elevation: 10,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.teal,
        selectedItemColor: Colors.white,
        elevation: 10,
        showSelectedLabels: true,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.teal,
        shape: CircularNotchedRectangle(),
      ),
      useMaterial3: true,
    );

    dark = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.teal,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 2, 70, 61),
      ),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        buttonColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.space,
        selectedItemColor: AppColors.teal,
        elevation: 10,
        showSelectedLabels: true,
      ),
      useMaterial3: true,
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
