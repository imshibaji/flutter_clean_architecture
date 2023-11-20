import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  static const String name = '/feature';
  static const String home = FeatureApp.name;
  static const String about = '${FeatureApp.name}/about';
  static const String contact = '${FeatureApp.name}/contact';

  FeatureApp() {
    addRoute(FeatureApp.home, (context) => const HomeController());
    addRoute(FeatureApp.about, (context) => const AboutController());
    addRoute(FeatureApp.contact, (context) => const ContactController());
  }
}
