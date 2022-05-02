import 'dart:convert';
import '../core/classes/cache_manager.dart';

class AppCache extends CacheManager {
  Map<String, String>? udata;

  void doLogin(String username, String password) {
    udata = {'user': username, 'pass': password};
    CacheManager.saveData('auth_data', jsonEncode(udata));
  }

  Future<Map<String, String>> auth() async {
    var data = await CacheManager.readData('auth_data');
    return udata = jsonDecode(data);
  }

  Future<bool> isLogin() async {
    var data = await CacheManager.readData('auth_data');
    if (data != null) {
      return true;
    }
    return false;
  }

  void doLogout() {
    CacheManager.deleteData('auth_data');
  }

  Future<bool> isLogout() async {
    var data = await CacheManager.readData('auth_data');
    if (data == null) {
      return true;
    }
    return false;
  }
}
