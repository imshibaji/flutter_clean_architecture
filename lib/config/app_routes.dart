import 'package:clean_archetructure/features/login_mod/login_app.dart';

import '../core/classes/route_manager.dart';
import '../features/feature-2/feature_app.dart';
import '../features/main_app/app.dart';

class Routes extends RouteManager {
  Routes() {
    addAll(App().routes);
    addAll(FeatureApp().routes);
    addAll(LoginApp().routes);
  }
}
