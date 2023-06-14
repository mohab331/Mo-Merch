import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for favorite-related operations.
abstract class BaseFavoriteRepo {
  /// Retrieves the favorite data.
  ///
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [ProductResponseEntity] representing the favorite data.
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>>
      getFavoriteData();

  /// Toggles the favorite status based on the provided [favoriteRequestEntity].
  ///
  /// Returns a [Future] of [Either] containing either a [Failure] or a [Map] of [String, dynamic] representing the result of toggling the favorite status.
  Future<Either<Failure, Map<String, dynamic>>> toggleFavorite({
    required FavoriteRequestEntity favoriteRequestEntity,
  });
}
