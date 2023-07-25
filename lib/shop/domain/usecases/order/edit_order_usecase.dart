import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class EditOrderUseCase
    implements
        BaseUsecase<BaseResponseEntity<EmptyResponseEntity>,
            int> {
  EditOrderUseCase({
    required this.baseOrderRepo,
  });

  BaseOrderRepo baseOrderRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>> call(
      int orderId,
      ) async {
    return  baseOrderRepo.editOrder(
      orderId: orderId,
    );
  }
}
