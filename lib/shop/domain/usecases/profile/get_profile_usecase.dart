import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetProfileUseCase implements BaseUsecase<ProfileResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetProfileUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, ProfileResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getUserProfile(parameters: parameters);
  }
}

