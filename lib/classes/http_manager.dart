import 'dart:developer';

import 'package:dio/dio.dart';

class HttpManager {
  final Dio _dio = Dio();

  HttpManager([String baseUrl = '', Map<String, dynamic>? headers]) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = headers;
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? token,
    Function(int progress, int total)? progress,
  }) async {
    Response? response;
    try {
      response = await _dio.get(
        url,
        queryParameters: params,
        options: options,
        cancelToken: token,
        onReceiveProgress: progress,
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
    return response!;
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? token,
    Function(int progress, int total)? sendProgress,
    Function(int progress, int total)? receiveProgress,
  }) async {
    Response? response;
    try {
      response = await _dio.post(
        url,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: token,
        onReceiveProgress: receiveProgress,
        onSendProgress: sendProgress,
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
    return response!;
  }
}
