import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with order-related operations.
abstract class BaseOrderRepo {
  /// Creates a new order based on the provided [addOrderRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [OrderResponseEntity] representing the created order.
  Future<Either<Failure, BaseResponseEntity<OrderResponseEntity>>> createOrder({
    required AddOrderRequestEntity addOrderRequestEntity,
  });

  /// Retrieves the list of orders.
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [OrderResponseEntity] representing the list of orders.
  Future<Either<Failure, BaseListResponseEntity<OrderResponseEntity>>>
      getOrders();

  /// Retrieves the details of a specific order based on the provided [orderDetailsRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseResponseEntity] of [OrderDetailsResponseEntity] representing the order details.
  Future<Either<Failure, BaseResponseEntity<OrderDetailsResponseEntity>>>
      getOrderDetails({
    required OrderDetailsRequestEntity orderDetailsRequestEntity,
  });
}
