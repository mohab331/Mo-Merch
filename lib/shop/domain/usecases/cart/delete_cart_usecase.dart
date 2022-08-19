import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class DeleteCartUseCase implements BaseUsecase<String ,DeleteUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  DeleteCartUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, String>> call(DeleteUseCaseParameters parameters) async{
    return await baseShopRepository.removeFromCart(parameters: parameters);
  }
}