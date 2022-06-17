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
  static const String addFollowup = name + '/add_followup';
  static const String listDeal = name + '/list_deal';
  static const String addDeal = name + '/add_deal';
  static const String printDeal = name + '/print_deal';
  static const String transactions = name + '/transactions';

  static const String contactList = name + '/contact_list';
  static const String contactPage = name + '/contact_page';

  static const String businessPage = name + '/business';
  static const String helpPage = name + '/help';
  static const String profile = name + '/profile';
  static const String settings = name + '/settings';

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
    addRoute(LeadApp.addFollowup, (context) => const AddFollowupController());

    // -----------------------------------
    addRoute(LeadApp.listDeal, (context) => const ListDealController());
    addRoute(printDeal, (context) => const PrintDealController());
    addRoute(addDeal, (context) => const AddDealController());

    // ------------------------------------
    addRoute(LeadApp.transactions, (context) => const TransactionsController());

    // -----------------------------------
    addRoute(contactList, (context) => const ContactListController());
    addRoute(contactPage, (context) => const ContactPageController());

    // Misc-------------------------------
    addRoute(businessPage, (context) => const BusinessController());
    addRoute(helpPage, (context) => const HelpController());
    addRoute(profile, (context) => const ProfileController());
    addRoute(settings, (context) => const SettingsController());
  }
}
