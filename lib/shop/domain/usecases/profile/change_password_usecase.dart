import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/change_password.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class ChangePasswordUsecase implements BaseUsecase<ChangePasswordResponse ,AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  ChangePasswordUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, ChangePasswordResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.changeUserPassword(parameters: parameters);
  }
}

