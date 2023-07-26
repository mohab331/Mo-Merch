import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddToCartUseCase
    implements
        BaseUsecase<BaseResponseEntity<CartItem>, AddToCartRequestEntity> {
  AddToCartUseCase({required this.baseCartRepo});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<CartItem>>> call(
    AddToCartRequestEntity addToCartRequestEntity,
  ) async {
    return baseCartRepo.addToCart(
      addToCartRequestEntity: addToCartRequestEntity,
    );
  }
}
