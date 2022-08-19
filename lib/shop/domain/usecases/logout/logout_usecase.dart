import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/logout.dart';
import '../../repository/base_shop_repository.dart';

class LogoutUsecase implements BaseUsecase<LogoutResponse , AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  LogoutUsecase({required this.baseShopRepository});
  @override
  Future<Either<Failure, LogoutResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.logout(parameters: parameters);
  }
}

