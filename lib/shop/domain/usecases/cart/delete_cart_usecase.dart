import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class DeleteCartUseCase
    implements BaseUsecase<BaseResponseEntity<EmptyResponseEntity>, DeleteCartItemRequestEntity> {
  DeleteCartUseCase({required this.baseCartRepo,});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>> call(
    DeleteCartItemRequestEntity deleteCartItemRequestEntity,
  ) async {
    return baseCartRepo.removeFromCart(
      deleteCartItemRequestEntity: deleteCartItemRequestEntity,
    );
  }
}
