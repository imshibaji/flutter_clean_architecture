import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../config/api_endpoints.dart';
import '../../../config/app_config.dart';
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

  Future<Enquery?> create(Lead lead) async {
    Response res = await _http.post(
      ApiEndpoint.enqueries,
      params: jsonDecode(
        EnqueryPost(
          data: EnqueryData(attributes: lead),
        ).toJson(),
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Enquery enquery = Enquery.fromJson(jsonEncode(res.data));
      return enquery;
    }
    return null;
  }

  Future<Enquery?> update(int id, Lead lead) async {
    Response res = await _http.put(
      ApiEndpoint.enqueries + '/' + id.toString(),
      data: jsonDecode(
        EnqueryPost(
          data: EnqueryData(attributes: lead),
        ).toJson(),
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Enquery enquery = Enquery.fromJson(jsonEncode(res.data));
      return enquery;
    }
    return null;
  }

  Future<Enquery?> delete(int id) async {
    Response res = await _http.put(
      ApiEndpoint.enqueries + '/' + id.toString(),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      Enquery enquery = Enquery.fromJson(jsonEncode(res.data));
      return enquery;
    }
    return null;
  }
}
