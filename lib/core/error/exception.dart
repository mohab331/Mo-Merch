import 'package:shop_app_clean_architecture/core/network/error_model.dart';

class ServerException implements Exception {
  const ServerException({
    required this.errorModel,
  });
  final ErrorModel errorModel;
}

class CacheException implements Exception {
  const CacheException({
    required this.errorMessage,
  });
  final String errorMessage;
}
