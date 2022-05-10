import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class App extends RouteManager {
  static String name = '';
  static String home = App.name + '/';
  static String about = App.name + '/about';
  static String contact = App.name + '/contact';
  static String news = App.name + '/news';

  App() {
    addRoute(App.home, (context) => const HomeController());
    addRoute(App.about, (context) => const AboutController());
    addRoute(App.contact, (context) => const ContactController());
    addRoute(App.news, (context) => const NewsController());
  }
}
