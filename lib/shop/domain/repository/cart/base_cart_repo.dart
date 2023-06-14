import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with cart-related operations.
abstract class BaseCartRepo {
  /// Adds an item to the cart based on the provided [addToCartRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [String] representing the operation result.
  Future<Either<Failure, String>> addToCart({
    required AddToCartRequestEntity addToCartRequestEntity,
  });

  /// Retrieves the cart data.
  /// Returns a [Future] of [Either] containing either a [Failure] or a [CartResponseEntity] representing the cart data.
  Future<Either<Failure, CartResponseEntity>> getCartData();

  /// Removes an item from the cart based on the provided [deleteCartItemRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [String] representing the operation result.
  Future<Either<Failure, String>> removeFromCart({
    required DeleteCartItemRequestEntity deleteCartItemRequestEntity,
  });

  /// Updates the cart based on the provided [updateCartRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [CartUpdateResponseEntity] representing the updated cart data.
  Future<Either<Failure, BaseResponseEntity<CartUpdateResponseEntity>>>
      updateCart({
    required UpdateCartRequestEntity updateCartRequestEntity,
  });
}
