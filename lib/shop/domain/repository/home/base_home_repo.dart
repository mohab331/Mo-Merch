import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for fetching home data.
abstract class BaseHomeRepo {
  /// Retrieves the home data.
  ///
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [HomeResponseEntity] representing the home data.
  Future<Either<Failure, BaseResponseEntity<HomeResponseEntity>>> getHomeData();
}
