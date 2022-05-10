import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  static String name = '/feature';
  static String home = FeatureApp.name + '';
  static String about = FeatureApp.name + '/about';
  static String contact = FeatureApp.name + '/contact';

  FeatureApp() {
    addRoute(FeatureApp.home, (context) => const HomeController());
    addRoute(FeatureApp.about, (context) => const AboutController());
    addRoute(FeatureApp.contact, (context) => const ContactController());
  }
}
