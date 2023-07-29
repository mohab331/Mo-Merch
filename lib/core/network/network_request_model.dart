import 'package:dio/dio.dart';

class NetworkRequestModel {
  NetworkRequestModel({
    required this.method,
    required this.path,
    this.requiresToken = true,
    this.responseType = ResponseType.json,
    this.headers,
    this.queryParameters,
    this.data,
    this.connectTimeout,
    this.receiveTimeOut,
  });

  /// If the `path` starts with 'http(s)', the `baseURL` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  final String path;

  final RequestType method;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic>? data;

  /// Timeout in milliseconds for opening  url.
  final int? connectTimeout;
  final int? receiveTimeOut;

  ///options which defined in [ResponseType] are `JSON`, `STREAM`, `PLAIN`.
  ///The default value is `JSON`, dio will parse response string to json object automatically
  ///when the content-type of response is 'application/json'.
  ///If you want to receive the response data with String, use `PLAIN`.
  final ResponseType? responseType;

  final bool requiresToken;
}

enum RequestType {
  post('POST'),
  delete('DELETE'),
  get('GET'),
  put('PUT');

  const RequestType(this.value);
  final String value;
}
