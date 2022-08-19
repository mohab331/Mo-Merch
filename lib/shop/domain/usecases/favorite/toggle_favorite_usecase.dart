import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class ToggleFavoriteUsecase implements BaseUsecase<Map<String,dynamic> ,AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  ToggleFavoriteUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, Map<String,dynamic>>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.toggleFavorite(parameters: parameters);
  }
}

