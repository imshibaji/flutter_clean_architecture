import '../../classes/route_manager.dart';
import 'controllers/controller.dart';

class FeatureApp extends RouteManager {
  FeatureApp() {
    addRoute('/feature', (context) => const HomeController());
    addRoute('/feature/about', (context) => const AboutController());
    addRoute('/feature/contact', (context) => const ContactController());
  }
}
