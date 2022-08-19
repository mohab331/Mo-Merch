import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryMap,
    String lang = 'en',
    String? token,
  });
  Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryMap,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  });
  Future<Response> putData({
    required String url,
    Map<String, dynamic>? queryMap,
    required Map<String, dynamic> data,
    String lang = 'en',
    required String token,
  });
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryMap,
    Map<String, dynamic>? data,
    String lang = 'en',
    required String token,
  });
}
