import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddToCartUseCase implements BaseUsecase<BaseResponseEntity<EmptyResponseEntity>, AddToCartRequestEntity> {
  AddToCartUseCase({required this.baseCartRepo});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<EmptyResponseEntity>>> call(
    AddToCartRequestEntity addToCartRequestEntity,
  ) async {
    return await baseCartRepo.addToCart(
      addToCartRequestEntity: addToCartRequestEntity,
    );
  }
}
