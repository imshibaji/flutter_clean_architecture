import 'package:clean_archetructure/core/classes/http_manager.dart';
import 'package:clean_archetructure/config/api_endpoints.dart';
import 'package:clean_archetructure/config/app_config.dart';

class Http extends HttpManager {
  Http([String? baseUrl, String? host, String? key])
      : super(baseUrl ?? ApiEndpoint.baseUrl, {
          'x-rapidapi-host': host ?? Config.host,
          'x-rapidapi-key': key ?? Config.key,
        });
}
