import '../classes/theme_manager.dart';
import '../classes/theme_provider.dart';

class ThemeProvider extends BaseThemeProvider {
  int _index = 0;

  get index => _index;

  setNavIndex(int index) {
    _index = index;
    notifyListeners();
  }
}

class MyTheme extends ThemeManager {}
