import 'package:dio/dio.dart';

/// An abstract class that defines the contract for making API requests.
abstract class ApiConsumer {
  /// Sends an HTTP GET request to the specified [url] and returns the response.
  ///
  /// - [url]: The URL to send the GET request to.
  /// - [queryMap]: A map of query parameters to be included in the request URL.
  /// - [requiresToken]: Indicates whether the request requires a token. Default is `true`.
  ///
  /// Returns a `Future<Response>` object representing the response received from the server.
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  });

  /// Sends an HTTP POST request to the specified [url] with the given [data] and returns the response.
  ///
  /// - [url]: The URL to send the POST request to.
  /// - [data]: The data to be sent in the request body.
  /// - [queryMap]: A map of query parameters to be included in the request URL.
  /// - [requiresToken]: Indicates whether the request requires a token. Default is `true`.
  ///
  /// Returns a `Future<Response>` object representing the response received from the server.
  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  });

  /// Sends an HTTP PUT request to the specified [url] with the given [data] and returns the response.
  ///
  /// - [url]: The URL to send the PUT request to.
  /// - [data]: The data to be sent in the request body.
  /// - [queryMap]: A map of query parameters to be included in the request URL.
  /// - [requiresToken]: Indicates whether the request requires a token. Default is `true`.
  ///
  /// Returns a `Future<Response>` object representing the response received from the server.
  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryMap,
    bool requiresToken = true,
  });

  /// Sends an HTTP DELETE request to the specified [url] and returns the response.
  ///
  /// - [url]: The URL to send the DELETE request to.
  /// - [queryMap]: A map of query parameters to be included in the request URL.
  /// - [data]: The data to be sent in the request body.
  /// - [requiresToken]: Indicates whether the request requires a token. Default is `true`.
  ///
  /// Returns a `Future<Response>` object representing the response received from the server.
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryMap,
    Map<String, dynamic>? data,
    bool requiresToken = true,
  });
}
