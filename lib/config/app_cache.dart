import 'dart:convert';
import '../core/classes/cache_manager.dart';

class AppCache {
  Map<String, String>? udata;

  void doLogin(String username, String password) {
    udata = {'user': username, 'pass': password};
    Cache.saveData('auth_data', jsonEncode(udata));
  }

  Future<Map<String, String>> auth() async {
    var data = await Cache.readData('auth_data');
    return udata = jsonDecode(data);
  }

  Future<bool> isLogin() async {
    var data = await Cache.readData('auth_data');
    if (data != null) {
      return true;
    }
    return false;
  }

  void doLogout() {
    Cache.deleteData('auth_data');
  }

  Future<bool> isLogout() async {
    var data = await Cache.readData('auth_data');
    if (data == null) {
      return true;
    }
    return false;
  }

  void enableOrDisableLoginScreen(bool isEnableOrDisable) {
    Cache.saveData('is_login_screen', isEnableOrDisable);
  }

  Future<bool> checkLoginScreen() async {
    return await Cache.readData('is_login_screen') as bool;
  }
}
