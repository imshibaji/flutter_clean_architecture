import '../../core/classes/route_manager.dart';
import 'controllers/controllers.dart';

class AuthApp extends RouteManager {
  static String name = '';
  static String login = AuthApp.name + '/login';
  static String profile = AuthApp.name + '/profile';
  static String forget = AuthApp.name + '/forget';
  static String register = AuthApp.name + '/register';

  AuthApp() {
    addRoute(AuthApp.login, (context) => const LoginController());
    addRoute(AuthApp.profile, (context) => const ProfileController());
    addRoute(AuthApp.forget, (context) => const ForgetController());
    addRoute(AuthApp.register, (context) => const RegisterController());
  }
}
