import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetCartUseCase implements BaseUsecase<CartResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetCartUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, CartResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getCartData(parameters: parameters);
  }
}