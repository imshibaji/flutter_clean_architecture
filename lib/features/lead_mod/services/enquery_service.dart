import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lead_book/config/app_config.dart';

import '../../../config/api_endpoints.dart';
import '../../../config/app_http.dart';
import '../models/enquery_get_models.dart';

class EnqueryService {
  final Http _http = Http(
    baseUrl: ApiEndpoint.baseUrl,
    token: Config.token,
  );

  Future<Enquery?> getAll() async {
    Response res = await _http.get(ApiEndpoint.enqueries);
    if (res.statusCode == 200) {
      Enquery enquery = Enquery.fromJson(jsonEncode(res.data));
      return enquery;
    }
    return null;
  }
}
