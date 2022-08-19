import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/login.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class LoginUsecase implements BaseUsecase<LoginResponse , AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  LoginUsecase({required this.baseShopRepository});
  @override
  Future<Either<Failure, LoginResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.loginUser(parameters: parameters);
  }
}

