import '../../core/classes/route_manager.dart';
import '../features.dart';
import 'controllers/controllers.dart';

class LeadApp extends RouteManager {
  static const String name = '/lead';
  static const String home = '$name/';
  static const String search = '$name/search';
  static const String addEnquery = '$name/add_enquery';
  static const String editEnquery = '$name/edit_enquery';
  static const String viewEnquery = '$name/view_enquery';
  static const String followup = '$name/followup';

  LeadApp() {
    addRoute(LeadApp.home, (context) => const DashboardController());
    addRoute(LeadApp.search, (context) => const SearchController());
    addRoute(LeadApp.addEnquery, (context) => const AddEnqueryController());
    addRoute(LeadApp.editEnquery, (context) => const EditEnqueryController());
    addRoute(LeadApp.viewEnquery, (context) => const ViewEnqueryController());
    addRoute(LeadApp.followup, (context) => const FollowupController());
  }
}
