import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class App extends RouteManager {
  static String name = '';
  App() {
    addRoute(App.name + '/', (context) => const HomeController());
    addRoute(App.name + '/about', (context) => const AboutController());
    addRoute(App.name + '/contact', (context) => const ContactController());
    addRoute(App.name + '/news', (context) => const NewsController());
  }
}
