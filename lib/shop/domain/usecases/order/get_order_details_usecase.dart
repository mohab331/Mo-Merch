import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetOrderDetailsUsecase
    implements
        BaseUsecase<BaseResponseEntity<OrderDetailsResponseEntity>,
            OrderDetailsRequestEntity> {
  GetOrderDetailsUsecase({required this.baseOrderRepo});

  BaseOrderRepo baseOrderRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<OrderDetailsResponseEntity>>> call(
    OrderDetailsRequestEntity orderDetailsRequestEntity,
  ) async {
    return await baseOrderRepo.getOrderDetails(
      orderDetailsRequestEntity: orderDetailsRequestEntity,
    );
  }
}
