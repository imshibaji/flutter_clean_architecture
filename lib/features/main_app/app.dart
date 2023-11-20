import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class App extends RouteManager {
  static const String name = '';
  static const String home = '${App.name}/';
  static const String about = '${App.name}/about';
  static const String contact = '${App.name}/contact';
  static const String news = '${App.name}/news';

  App() {
    addRoute(App.home, (context) => const HomeController());
    addRoute(App.about, (context) => const AboutController());
    addRoute(App.contact, (context) => const ContactController());
    addRoute(App.news, (context) => const NewsController());
  }
}
