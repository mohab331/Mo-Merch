import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// Implementation of the `BaseOrderRepo` interface.
///
/// This class handles the creation of orders, retrieval of order details, and retrieval of orders.
class OrderRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseOrderRepo {
  /// Constructs an instance of `OrderRepoImpl` with the required dependencies.
  ///
  /// The [baseShopRemoteDS] is the remote data source for the shop.
  /// The [addOrderRequestMapper] is the mapper for converting add order request entities to models.
  /// The [baseOrderResponseMapper] is the mapper for converting order response models to entities.
  /// The [orderDetailsRequestMapper] is the mapper for converting order details request entities to models.
  /// The [baseOrderDetailsResponseMapper] is the mapper for converting order details response models to entities.
  /// The [baseListOrderResponseMapper] is the mapper for converting list order response models to entities.
  OrderRepoImpl({
    required this.baseShopRemoteDS,
    required this.addOrderRequestMapper,
    required this.baseOrderResponseMapper,
    required this.orderDetailsRequestMapper,
    required this.baseOrderDetailsResponseMapper,
    required this.baseListOrderResponseMapper,
    required this.emptyResponseMapper,
  });
  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseMapper<AddOrderRequestModel, AddOrderRequestEntity>
      addOrderRequestMapper;
  final BaseResponseMapper<OrderResponseModel, OrderResponseEntity>
      baseOrderResponseMapper;
  final BaseMapper<OrderDetailsRequestModel, OrderDetailsRequestEntity>
      orderDetailsRequestMapper;
  final BaseResponseMapper<OrderDetailsResponseModel,
      OrderDetailsResponseEntity> baseOrderDetailsResponseMapper;
  final BaseListResponseMapper<OrderResponseModel, OrderResponseEntity>
      baseListOrderResponseMapper;
  final BaseResponseMapper<EmptyResponseModel, EmptyResponseEntity>
      emptyResponseMapper;

  /// Creates a new order.
  ///
  /// This method sends an add order request to the remote data source using the `createOrder` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<OrderResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<OrderResponseEntity>>> createOrder({
    required AddOrderRequestEntity addOrderRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<OrderResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.createOrder(
          addOrderRequestModel: addOrderRequestMapper.mapToModel(
            entity: addOrderRequestEntity,
          ),
        );
        return baseOrderResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Retrieves the order details for the given [orderDetailsRequestEntity].
  ///
  /// This method sends an order details request to the remote data source using the `getOrderDetails` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<OrderDetailsResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<OrderDetailsResponseEntity>>>
      getOrderDetails({
    required OrderDetailsRequestEntity orderDetailsRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<OrderDetailsResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getOrderDetails(
          orderDetailsRequestModel: orderDetailsRequestMapper.mapToModel(
            entity: orderDetailsRequestEntity,
          ),
        );
        return baseOrderDetailsResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Retrieves the list of orders.
  ///
  /// This method sends a request to the remote data source using the `getOrders` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseListResponseEntity<OrderResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseListResponseEntity<OrderResponseEntity>>>
      getOrders({required int page}) async {
    return executeWithNetworkAndExceptionHandling<
        BaseListResponseEntity<OrderResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getOrders(page: page);
        return baseListOrderResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>> editOrder(
      {required int orderId}) {
    return executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<EmptyResponseEntity>>(() async {
      final response = await baseShopRemoteDS.editOrder(orderId: orderId);
      return emptyResponseMapper.mapToEntity(model: response);
    });
  }
}
