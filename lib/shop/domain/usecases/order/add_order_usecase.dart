import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddOrderUseCase
    implements
        BaseUsecase<BaseResponseEntity<OrderResponseEntity>,
            AddOrderRequestEntity> {
  AddOrderUseCase({
    required this.baseOrderRepo,
  });

  BaseOrderRepo baseOrderRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<OrderResponseEntity>>> call(
    AddOrderRequestEntity addOrderRequestEntity,
  ) async {
    return baseOrderRepo.createOrder(
      addOrderRequestEntity: addOrderRequestEntity,
    );
  }
}
