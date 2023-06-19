import 'dart:convert';

import 'package:dio/dio.dart';

/// An interceptor for handling requests and responses in the ShopApp application.
///
/// This interceptor is responsible for handling requests that require a token
/// and converting response data to a JSON map.
class ShopAppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if the request headers contain the 'requiresToken' key
    // and its value is true
    if (options.headers.containsKey('requiresToken') &&
        options.headers['requiresToken'] == true) {
      // Remove the 'requiresToken' header
      options.headers.remove('requiresToken');

      // Continue with the request
      return handler.next(options);
    }
  }

  @override
  Map<String, dynamic>? onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // Check if the response data is not empty
    if (response.data != null) {
      // Convert the response data to JSON using Dio's default converter
      var jsonData = json.decode(response.data.toString());

      // Return the JSON data as a Map<String, dynamic>
      return Map<String, dynamic>.from(jsonData);
    }

    // Return null if the response data is empty
    return null;
  }
}
