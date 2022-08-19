import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/home.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetHomeUsecase implements BaseUsecase<HomeResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetHomeUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, HomeResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getHomeData(parameters: parameters);
  }
}

