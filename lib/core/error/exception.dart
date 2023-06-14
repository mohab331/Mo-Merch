import 'package:shop_app_clean_architecture/core/network/error_model.dart';

class ServerException implements Exception{
  final ErrorModel errorModel;
  ServerException({required this.errorModel});
}

class CacheException implements Exception{
  final String errorMessage;
  CacheException({required this.errorMessage});
}

