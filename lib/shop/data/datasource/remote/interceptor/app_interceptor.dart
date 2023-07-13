import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// An interceptor for handling requests and responses in the ShopApp application.
///
/// This interceptor is responsible for handling requests that require a token
/// and converting response data to a JSON map.
class ShopAppInterceptor extends Interceptor {
  ShopAppInterceptor({
    required this.getCachedUserDataUsecase,
  });
  final GetCachedUserDataUsecase getCachedUserDataUsecase;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      'lang': 'en',
    });
    // Check if the request headers contain the 'requiresToken' key
    // and its value is true
    if (options.headers.containsKey('requiresToken') &&
        options.headers['requiresToken'] == true) {
      // Remove the 'requiresToken' header
      options.headers.remove('requiresToken');
      // Continue with the request
      final response =
          await getCachedUserDataUsecase.call(const NoParameters());
      response.fold((l) {}, (r) {
        options.headers.addAll({
          'Authorization': r?.token,
        });
      });
    }
    return handler.next(options);
  }
}
