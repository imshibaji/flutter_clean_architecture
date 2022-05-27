import '../../core/classes/route_manager.dart';
import '../features.dart';
import 'controllers/controllers.dart';

class LeadApp extends RouteManager {
  static const String name = '';
  static const String home = name + '/';
  static const String search = name + '/search';
  static const String listEnquery = name + '/list_enquery';
  static const String addEnquery = name + '/add_enquery';
  static const String editEnquery = name + '/edit_enquery';
  static const String viewEnquery = name + '/view_enquery';
  static const String followup = name + '/followup';
  static const String listDeal = name + '/list_deal';
  static const String transactions = name + '/transactions';

  LeadApp() {
    addRoute(LeadApp.home, (context) => const DashboardController());
    addRoute(LeadApp.listEnquery, (context) => const ListEnqueryController());
    addRoute(LeadApp.search, (context) => const SearchController());
    addRoute(LeadApp.addEnquery, (context) => const AddEnqueryController());
    addRoute(LeadApp.editEnquery, (context) => const EditEnqueryController());
    addRoute(LeadApp.viewEnquery, (context) => const ViewEnqueryController());
    addRoute(LeadApp.followup, (context) => const FollowupController());
    addRoute(LeadApp.listDeal, (context) => const ListDealController());
    addRoute(LeadApp.transactions, (context) => const TransactionsController());
  }
}
