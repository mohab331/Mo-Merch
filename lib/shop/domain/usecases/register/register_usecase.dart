import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/register.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class RegisterUsecase implements BaseUsecase<RegisterResponse , AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  RegisterUsecase({required this.baseShopRepository});
  @override
  Future<Either<Failure, RegisterResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.registerUser(parameters: parameters);
  }
}

