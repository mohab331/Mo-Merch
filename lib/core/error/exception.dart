import 'package:shop_app_clean_architecture/core/index.dart';

class ServerException implements Exception {

  const ServerException.fromApi({
    required this.errorModel,
  });
  final ErrorModel? errorModel;
}

class CacheException implements Exception {
  const CacheException({
    required this.errorMessage,
  });
  final String errorMessage;
}
