import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class AddToCartUseCase implements BaseUsecase<String , AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  AddToCartUseCase({required this.baseShopRepository});
  @override
  Future<Either<Failure, String>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.addToCart(parameters: parameters);
  }
}

