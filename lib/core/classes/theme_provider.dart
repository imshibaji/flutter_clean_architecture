import 'package:flutter/material.dart';

import 'classes.dart';

class BaseThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  BaseThemeProvider() {
    checkDarkMode();
  }

  checkDarkMode() async {
    bool isDark = await Cache.readData('isDark');
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    Cache.saveData('isDark', isOn);
    notifyListeners();
  }
}
