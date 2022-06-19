import '../core/classes/route_manager.dart';
import '../features/awasome_notification/awasome_notification_app.dart';
// import '../features/auth_mod/auth_app.dart';
import '../features/lead_mod/lead_app.dart';
import '../features/splash_app/splash_app.dart';

class Routes extends RouteManager {
  Routes() {
    addAll(SplashApp().routes);
    // addAll(AuthApp().routes);
    addAll(LeadApp().routes);
    addAll(AwasomeNotificationApp().routes);
  }
}
