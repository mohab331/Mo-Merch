import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class UpdateProfileUseCase implements BaseUsecase<ProfileResponse ,UpdateUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  UpdateProfileUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, ProfileResponse>> call(UpdateUseCaseParameters parameters) async{
    return await baseShopRepository.updateUserProfile(parameters: parameters);
  }
}

