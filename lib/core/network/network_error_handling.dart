import 'package:dio/dio.dart';

class NetworkErrorHandler implements Exception {
  NetworkErrorHandler.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioExceptionType.connectionError:
        message = 'Receive timeout in connection with API server';
        break;
      case DioExceptionType.badResponse:
        {
          errorStatusCode = dioError.response?.statusCode;
          message = _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          );
        }
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') == true) {
          message = 'No Internet';
          break;
        }
        message = 'Unexpected error occurred';
        break;
      default:
        message = 'Something went wrong';
        break;
    }
  }
  late String message;
  int? errorStatusCode;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }
}
