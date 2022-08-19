import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/favorite.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetFavoriteUsecase implements BaseUsecase<FavoriteResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetFavoriteUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, FavoriteResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getFavoriteData(parameters: parameters);
  }
}

