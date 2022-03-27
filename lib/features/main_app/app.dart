import '../../core/classes/route_manager.dart';
import 'controllers/controller.dart';

class App extends RouteManager {
  App() {
    addRoute('/', (context) => const HomeController());
    addRoute('/about', (context) => const AboutController());
    addRoute('/contact', (context) => const ContactController());
    addRoute('/news', (context) => const NewsController());
  }
}
