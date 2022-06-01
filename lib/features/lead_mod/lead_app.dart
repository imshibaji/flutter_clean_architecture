import '../../core/classes/route_manager.dart';
import 'controllers/controllers.dart';

class LeadApp extends RouteManager {
  static const String name = '';
  static const String home = name + '/';
  static const String search = name + '/search';
  static const String listEnquery = name + '/list_enquery';
  static const String addEnquery = name + '/add_enquery';
  static const String editEnquery = name + '/edit_enquery';
  static const String viewEnquery = name + '/view_enquery';

  static const String listLeads = name + '/list_leads';
  static const String viewLead = name + '/view_lead';
  static const String addLead = name + '/add_lead';
  static const String editLead = name + '/edit_lead';

  static const String followup = name + '/followup';
  static const String listDeal = name + '/list_deal';
  static const String transactions = name + '/transactions';

  LeadApp() {
    addRoute(LeadApp.home, (context) => const DashboardController());
    addRoute(LeadApp.search, (context) => const SearchController());

    // Enquery Section
    addRoute(LeadApp.listEnquery, (context) => const ListEnqueryController());
    addRoute(LeadApp.addEnquery, (context) => const AddEnqueryController());
    addRoute(LeadApp.editEnquery, (context) => const EditEnqueryController());
    addRoute(LeadApp.viewEnquery, (context) => const ViewEnqueryController());

    // Leads Section
    addRoute(listLeads, (context) => const ListLeadController());
    addRoute(addLead, (context) => const AddLeadController());
    addRoute(editLead, (context) => const EditLeadController());
    addRoute(viewLead, (context) => const ViewLeadController());

    /// ----------------------------------
    addRoute(LeadApp.followup, (context) => const FollowupController());
    addRoute(LeadApp.listDeal, (context) => const ListDealController());
    addRoute(LeadApp.transactions, (context) => const TransactionsController());
  }
}
