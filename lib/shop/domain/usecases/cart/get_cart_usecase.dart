import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCartUseCase implements BaseUsecase<CartResponseEntity, NoParameters> {
  GetCartUseCase({required this.baseCartRepo});

  BaseCartRepo baseCartRepo;

  @override
  Future<Either<Failure, CartResponseEntity>> call(
    NoParameters parameters,
  ) async {
    return await baseCartRepo.getCartData();
  }
}
