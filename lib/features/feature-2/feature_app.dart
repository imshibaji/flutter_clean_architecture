import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  static String name = '/feature';
  FeatureApp() {
    addRoute(FeatureApp.name + '', (context) => const HomeController());
    addRoute(FeatureApp.name + '/about', (context) => const AboutController());
    addRoute(
        FeatureApp.name + '/contact', (context) => const ContactController());
  }
}
