import '../../core/classes/route_manager.dart';
import 'awasome_notification.dart';

class AwasomeNotificationApp extends RouteManager {
  static const String name = 'awasome_notify';
  static const String home = name + '/';

  AwasomeNotificationApp() {
    addRoute(AwasomeNotificationApp.home,
        (context) => const AwasomeNotificationUi());
  }
}
