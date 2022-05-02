import 'package:clean_archetructure/core/classes/route_manager.dart';
import 'package:clean_archetructure/features/login_mod/controller/login_controller.dart';

class LoginApp extends RouteManager {
  LoginApp() {
    addRoute('/login', (context) => const LoginController());
  }
}
