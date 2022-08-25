import '../core/classes/route_manager.dart';
import '../features/auth_mod/auth_app.dart';
import '../features/feature-2/feature_app.dart';
import '../features/lead_mod/lead_app.dart';
import '../features/main_app/app.dart';

class Routes extends RouteManager {
  Routes() {
    addAll(AuthApp().routes);
    addAll(LeadApp().routes);
    addAll(App().routes);
    addAll(FeatureApp().routes);
  }
}
