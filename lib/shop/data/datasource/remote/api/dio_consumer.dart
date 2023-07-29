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
  Future<Response> request({
    required NetworkRequestModel networkRequestModel,
  }) async {
    try {
      final options = Options();
      options
        ..method = networkRequestModel.method.value
        ..headers?.addAll(networkRequestModel.headers ?? {})
        ..responseType = networkRequestModel.responseType
        ..receiveTimeout = Duration(
          seconds: networkRequestModel.receiveTimeOut ?? 10,
        );
      final response = await dio.request(
        networkRequestModel.path,
        options: _addTokenHeader(
          options,
          networkRequestModel.requiresToken,
        ),
        data: networkRequestModel.data,
        queryParameters: networkRequestModel.queryParameters,
      );
      return response;
    } on DioException catch (error) {
      NetworkErrorHandler errorHandler =
          NetworkErrorHandler.fromDioError(error);
      throw ServerException.fromApi(
        errorModel: ErrorModel.fromJson(
          jsonMap: {
            'message': errorHandler.message,
            'statusCode': errorHandler.errorStatusCode,
          },
        ),
      );
    }
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
        options.headers?.addAll({
          'requiresToken': true,
        });
      }
    }
    return options;
  }
}
