import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../config/api_endpoints.dart';
import '../../../config/app_config.dart';
import '../../../config/app_http.dart';
import '../models/model.dart';

class NewsProvider extends ChangeNotifier {
  final AppHttp _http = AppHttp(baseUrl: ApiEndpoint.rapidUrl, headers: {
    'x-rapidapi-host': Config.host,
    'x-rapidapi-key': Config.key,
    'Authorization': Config.token,
  });
  NewsResponseModel? _nrm;
  bool isLoading = false;

  NewsResponseModel get newsResponse => _nrm!;

  void search(String searchTerm, {bool input = true}) async {
    if (isLoading == true) {
      isLoading = false;
    }

    Response res = await _http
        .get(ApiEndpoint.news, params: {'q': searchTerm, 'lang': 'en'});
    if (res.statusCode == 200 && res.statusCode != 429) {
      // print(res);
      _nrm = NewsResponseModel.fromJson(res.toString());
      isLoading = true;
      input = false;
      notifyListeners();
    }
  }
}
