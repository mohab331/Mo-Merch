import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';

/// A class that encapsulates Dio HTTP client and provides methods for making API requests.
class DioConsumer implements ApiConsumer {
  /// Constructs a [DioConsumer] with the provided [dio] instance.
  ///
  /// The [dio] is the Dio HTTP client used for making API requests.
  DioConsumer({
    required this.dio,
  }) {
    _configureDio();
    _addInterceptors();
  }

  final Dio dio;

  /// Configures the Dio instance with default options.
  ///
  /// This method sets up the base URL, headers, timeouts, and other default options for the Dio instance.
  void _configureDio() {
    dio.options
      ..baseUrl = ApiConstants.baseUrl
      ..followRedirects = false
      ..headers = {
        ApiConstants.contentType: ApiConstants.applicationJson,
      }
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10)
      ..receiveDataWhenStatusError = true;
  }

  /// Adds interceptors to the Dio instance.
  ///
  /// This method adds custom interceptors to the Dio instance for handling request and response logging, as well as applying additional logic.
  void _addInterceptors() {
    dio.interceptors.add(
      diInstance.get<ShopAppInterceptor>(),
    );
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  @override
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryMap,
    Map<String, dynamic>? data,
    bool requiresToken = true,
  }) async {
    final options = Options();
    return dio.delete(
      url,
      queryParameters: queryMap,
      data: data,
      options: _addTokenHeader(options, requiresToken),
    ).onError((error, stackTrace) => throw ServerException(errorModel: ErrorModel.fromJson(jsonMap: {'message':error.toString(),}),),);
  }

  @override
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  }) async {
    final options = Options();
    return dio.get(
      url,
      queryParameters: queryMap,
      options: _addTokenHeader(options, requiresToken),
    ).onError((error, stackTrace) => throw ServerException(errorModel: ErrorModel.fromJson(jsonMap: {'message':error.toString(),}),),);
  }

  @override
  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  }) async {
    final options = Options();
    return dio.post(
      url,
      queryParameters: queryMap,
      data: data,
      options: _addTokenHeader(options, requiresToken),
    ).onError((error, stackTrace) => throw ServerException(errorModel: ErrorModel.fromJson(jsonMap: {'message':error.toString(),}),),);
  }

  @override
  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  }) async {
    final options = Options();
    return dio.put(
      url,
      queryParameters: queryMap,
      data: data,
      options: _addTokenHeader(options, requiresToken),
    ).onError((error, stackTrace) => throw ServerException(errorModel: ErrorModel.fromJson(jsonMap: {'message':error.toString(),}),),);
  }

  /// Adds the `requiresToken` header to the request options if required.
  ///
  /// The [options] is the request options object.
  /// The [requiresToken] flag indicates whether the request requires a token or not.
  Options _addTokenHeader(Options options, bool requiresToken) {
    if (requiresToken) {
      if (options.headers == null) {
        options.headers = {'requiresToken': true};
      } else {
        options.headers?.addAll({'requiresToken': true});
      }
    }
    return options;
  }
}
