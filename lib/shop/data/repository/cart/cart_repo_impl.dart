import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';

/// A repository implementation for handling cart-related operations.
class CartRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseCartRepo {
  CartRepoImpl({
    required this.baseShopRemoteDS,
    required this.addToCartRequestMapper,
    required this.baseCartResponseMapper,
    required this.baseCartUpdateResponseMapper,
    required this.baseEmptyResponseMapper,
    required this.deleteCartRequestMapper,
    required this.updateCartRequestMapper,
  });

  final BaseShopRemoteDS baseShopRemoteDS;

  final BaseMapper<AddToCartRequestModel, AddToCartRequestEntity>
      addToCartRequestMapper;
  final BaseMapper<UpdateCartRequestModel, UpdateCartRequestEntity>
      updateCartRequestMapper;
  final BaseMapper<DeleteCartItemRequestModel, DeleteCartItemRequestEntity>
      deleteCartRequestMapper;
  final BaseResponseMapper<EmptyResponseModel, EmptyResponseEntity>
      baseEmptyResponseMapper;
  final BaseResponseMapper<CartResponseModel, CartResponseEntity>
      baseCartResponseMapper;
  final BaseResponseMapper<CartUpdateResponseModel, CartUpdateResponseEntity>
      baseCartUpdateResponseMapper;

  /// Adds an item to the cart.
  ///
  /// Returns a [BaseResponseEntity] of [EmptyResponseEntity] with an empty response if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>> addToCart({
    required AddToCartRequestEntity addToCartRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<EmptyResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.addToCart(
          addToCartRequestModel: addToCartRequestMapper.mapToModel(
            entity: addToCartRequestEntity,
          ),
        );
        return baseEmptyResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Retrieves the cart data.
  ///
  /// Returns a [BaseResponseEntity] of [CartResponseEntity] with the cart information if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<CartResponseEntity>>>
      getCartData() async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<CartResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getCartData();
        return baseCartResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Removes an item from the cart.
  ///
  /// Returns a [BaseResponseEntity] of [EmptyResponseEntity] with an empty response if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>>
      removeFromCart({
    required DeleteCartItemRequestEntity deleteCartItemRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<EmptyResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.removeFromCart(
          deleteCartItemRequestModel: deleteCartRequestMapper.mapToModel(
            entity: deleteCartItemRequestEntity,
          ),
        );
        return baseEmptyResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Updates the quantity of an item in the cart.
  ///
  /// Returns a [BaseResponseEntity] of [CartUpdateResponseEntity] with the updated cart information if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseResponseEntity<CartUpdateResponseEntity>>>
      updateCart({
    required UpdateCartRequestEntity updateCartRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<CartUpdateResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.updateCart(
          updateCartRequestModel: updateCartRequestMapper.mapToModel(
            entity: updateCartRequestEntity,
          ),
        );
        return baseCartUpdateResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
