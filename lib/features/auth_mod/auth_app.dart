import '../../core/classes/route_manager.dart';
import 'controllers/controllers.dart';

class AuthApp extends RouteManager {
  AuthApp() {
    addRoute('/login', (context) => const LoginController());
    addRoute('/profile', (context) => const ProfileController());
    addRoute('/forget', (context) => const ForgetController());
    addRoute('/register', (context) => const RegisterController());
  }
}
