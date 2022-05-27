import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'classes.dart';

class BaseThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  BaseThemeProvider() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      checkDarkMode();
    });
  }

  checkDarkMode() async {
    bool isDark = await Cache.readData('isDark') ?? false;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    Cache.saveData('isDark', isOn);
    notifyListeners();
  }
}
