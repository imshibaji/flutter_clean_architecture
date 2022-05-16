import 'package:lead_book/core/classes/route_manager.dart';
import 'package:lead_book/features/lead_mod/controllers/controllers.dart';

class LeadApp extends RouteManager {
  LeadApp() {
    addRoute('/', (context) => const DashboardController());
    addRoute('/about', (context) => const AboutController());
  }
}
