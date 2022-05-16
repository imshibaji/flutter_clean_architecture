import '../core/classes/http_manager.dart';
import 'api_endpoints.dart';
import 'app_config.dart';

class Http extends HttpManager {
  Http([String? baseUrl, String? token, String? key])
      : super(baseUrl ?? ApiEndpoint.baseUrl, {
          'Authorization': token ?? Config.token,
        });
}
