import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../repository/base_shop_repository.dart';


class ClearCachedUserDataUsecase implements BaseUsecase<dynamic , NoParameters>{
  BaseShopRepository baseShopRepository;
  ClearCachedUserDataUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, dynamic>> call(NoParameters parameters) async{
    return await baseShopRepository.clearUserData();
  }


}