import 'package:clean_archetructure/classes/http_manager.dart';
import 'package:clean_archetructure/core/api_endpoints.dart';
import 'package:clean_archetructure/core/app_config.dart';

class Http extends HttpManager {
  Http([String? baseUrl, String? host, String? key])
      : super(baseUrl ?? ApiEndpoint.baseUrl, {
          'x-rapidapi-host': host ?? Config.host,
          'x-rapidapi-key': key ?? Config.key,
        });
}
