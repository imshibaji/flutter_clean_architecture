import 'package:clean_archetructure/core/classes/route_manager.dart';
import 'package:clean_archetructure/features/auth_mod/controller/forget_controller.dart';
import 'package:clean_archetructure/features/auth_mod/controller/login_controller.dart';
import 'package:clean_archetructure/features/auth_mod/controller/profile_controller.dart';
import 'package:clean_archetructure/features/auth_mod/controller/register_controller.dart';

class AuthApp extends RouteManager {
  AuthApp() {
    addRoute('/login', (context) => const LoginController());
    addRoute('/profile', (context) => const ProfileController());
    addRoute('/forget', (context) => const ForgetController());
    addRoute('/register', (context) => const RegisterController());
  }
}
