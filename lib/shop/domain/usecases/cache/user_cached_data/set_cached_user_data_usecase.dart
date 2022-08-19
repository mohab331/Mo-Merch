import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';

import '../../../../../core/error/failure.dart';
import '../../../repository/base_shop_repository.dart';


class SetCachedUserDataUsecase implements BaseUsecase<bool , SetCachedUserDataUsecaseParameters>{
  BaseShopRepository baseShopRepository;
  SetCachedUserDataUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, bool>> call(SetCachedUserDataUsecaseParameters parameters) async{
    return await baseShopRepository.setUserData(parameters: parameters);
  }

}
class SetCachedUserDataUsecaseParameters{
  final String name;
  final String token;
  SetCachedUserDataUsecaseParameters({required this.token , required this.name,});
}