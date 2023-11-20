import '../../core/classes/route_manager.dart';
import 'controllers/controllers.dart';

class AuthApp extends RouteManager {
  static const String name = '';
  static const String login = '${AuthApp.name}/login';
  static const String profile = '${AuthApp.name}/profile';
  static const String forget = '${AuthApp.name}/forget';
  static const String register = '${AuthApp.name}/register';

  AuthApp() {
    addRoute(AuthApp.login, (context) => const LoginController());
    addRoute(AuthApp.profile, (context) => const ProfileController());
    addRoute(AuthApp.forget, (context) => const ForgetController());
    addRoute(AuthApp.register, (context) => const RegisterController());
  }
}
