import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

/// An abstract class that defines the contract for making API requests.
abstract class ApiConsumer {
  Future<Response> request({
    required NetworkRequestModel networkRequestModel,
  });
}
