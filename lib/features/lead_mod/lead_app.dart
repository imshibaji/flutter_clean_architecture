import '../../core/classes/route_manager.dart';
import '../features.dart';
import 'controllers/controllers.dart';

class LeadApp extends RouteManager {
  static const String name = '/lead';
  static const String home = name + '/';
  static const String about = name + '/about';
  static const String addEnquery = name + '/add_enquery';
  static const String editEnquery = name + '/edit_enquery';

  LeadApp() {
    addRoute(LeadApp.home, (context) => const DashboardController());
    addRoute(LeadApp.about, (context) => const AboutController());
    addRoute(LeadApp.addEnquery, (context) => const AddEnqueryController());
    addRoute(LeadApp.editEnquery, (context) => const EditEnqueryController());
  }
}
