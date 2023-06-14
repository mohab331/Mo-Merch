import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class DeleteCartUseCase
    implements BaseUsecase<String, DeleteCartItemRequestEntity> {
  DeleteCartUseCase({required this.baseCartRepo,});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, String>> call(
    DeleteCartItemRequestEntity deleteCartItemRequestEntity,
  ) async {
    return await baseCartRepo.removeFromCart(
      deleteCartItemRequestEntity: deleteCartItemRequestEntity,
    );
  }
}
