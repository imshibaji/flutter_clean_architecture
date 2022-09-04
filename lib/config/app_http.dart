import '../core/classes/http_manager.dart';

class AppHttp extends HttpManager {
  AppHttp({String? baseUrl, Map<String, dynamic>? headers})
      : super(baseUrl!, headers!);
}
