import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../repository/base_shop_repository.dart';


class SetOnBoardingUsecase implements BaseUsecase<bool , NoParameters>{
  BaseShopRepository baseShopRepository;
  SetOnBoardingUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, bool>> call(NoParameters parameters) async{
    return await baseShopRepository.setOnBoarding();
  }

}