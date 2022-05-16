import '../core/classes/http_manager.dart';
import 'api_endpoints.dart';
import 'app_config.dart';

class Http extends HttpManager {
  Http({
    String? baseUrl,
    String? host,
    String? key,
    String? token,
  }) : super(baseUrl ?? ApiEndpoint.baseUrl, {
          'x-rapidapi-host': host ?? Config.host,
          'x-rapidapi-key': key ?? Config.key,
          'Authorization': token ?? Config.token,
        });
}
