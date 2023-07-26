import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class UpdateCartUsecase
    implements
        BaseUsecase<BaseResponseEntity<CartUpdateResponseEntity>,
            UpdateCartRequestEntity> {
  UpdateCartUsecase({required this.baseCartRepo});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<CartUpdateResponseEntity>>> call(
    UpdateCartRequestEntity updateCartRequestEntity,
  ) async {
    return baseCartRepo.updateCart(
      updateCartRequestEntity: updateCartRequestEntity,
    );
  }
}
