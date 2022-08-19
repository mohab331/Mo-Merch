import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';

import '../../repository/base_shop_repository.dart';

class UpdateCartUsecase implements BaseUsecase<CartUpdateResponse ,UpdateUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  UpdateCartUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, CartUpdateResponse>> call(UpdateUseCaseParameters parameters) async{
    return await baseShopRepository.updateCart(parameters: parameters,);
  }
}

