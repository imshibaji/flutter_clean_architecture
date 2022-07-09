import '../../core/classes/route_manager.dart';
import 'awesome_notification.dart';

class AwesomeNotificationApp extends RouteManager {
  static const String name = 'awesome_notify';
  static const String home = name + '/';

  AwesomeNotificationApp() {
    addRoute(AwesomeNotificationApp.home,
        (context) => const AwesomeNotificationUi());
  }
}
