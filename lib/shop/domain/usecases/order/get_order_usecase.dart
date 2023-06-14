import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetOrderUsecase
    implements
        BaseUsecase<BaseListResponseEntity<OrderResponseEntity>, NoParameters> {
  GetOrderUsecase({
    required this.baseOrderRepo,
  });

  BaseOrderRepo baseOrderRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<OrderResponseEntity>>> call(
    NoParameters parameters,
  ) async {
    return await baseOrderRepo.getOrders();
  }
}
