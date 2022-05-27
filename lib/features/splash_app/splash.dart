import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class SplashApp extends RouteManager {
  static const String name = 'splash';
  static const String home = SplashApp.name + '/';

  SplashApp() {
    addRoute(SplashApp.home, (context) => const SplashController());
  }
}
