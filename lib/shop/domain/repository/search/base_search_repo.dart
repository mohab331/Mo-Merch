import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for searching products.
abstract class BaseSearchRepo {
  /// Searches for products based on the provided [searchRequestEntity].
  ///
  /// Returns a [Future] of [Either] containing either a [Failure] or a [SearchResponseEntity] representing the search results.
  Future<Either<Failure, SearchResponseEntity>> searchProduct({
    required SearchRequestEntity searchRequestEntity,
  });
}
