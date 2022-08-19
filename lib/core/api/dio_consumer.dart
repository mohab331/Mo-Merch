import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/api/api_constants.dart';
import 'package:shop_app_clean_architecture/core/api/api_consumer.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;

class DioConsumer implements ApiConsumer {
  Dio dio;
  DioConsumer({required this.dio}) {
    dio.options
      ..baseUrl = ApiConstants.baseUrl
      ..followRedirects = false
      ..headers = {
        ApiConstants.contentType: ApiConstants.applicationJson,
      }
      ..receiveDataWhenStatusError = true;
    dio.interceptors.add(di.sl<LogInterceptor>());
  }

  @override
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryMap,
    Map<String, dynamic>? data,
    String lang = 'en',
    required String token,
  }) async {
    return await dio.delete(url,
        queryParameters: queryMap,
        data: data,
        options: Options(headers: {
          ApiConstants.authorization: token,
          ApiConstants.language: lang,
        },),
    );
  }

  @override
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryMap,
    String lang = 'en',
    String? token,
  }) async {
    return await dio.get(
      url,
      queryParameters: queryMap,
      options: Options(
        headers: {
          ApiConstants.language: lang,
          ApiConstants.authorization: token,
        },
      ),
    );
  }

  @override
  Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryMap,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    return await dio.post(
      url,
      queryParameters: queryMap,
      data: data,
      options: Options(
        headers: {
          ApiConstants.language: lang,
          ApiConstants.authorization: token,
        },
      ),
    );
  }

  @override
  Future<Response> putData(
      {required String url,
      Map<String, dynamic>? queryMap,
      required Map<String, dynamic> data,
      String lang = 'en',
      required String token}) async {
    return await dio.put(
      url,
      queryParameters: queryMap,
      data: data,
      options: Options(
        headers: {
          ApiConstants.authorization: token,
          ApiConstants.language: lang,
        },
      ),
    );
  }
}
