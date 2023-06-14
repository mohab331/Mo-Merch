import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class UpdateProfileUseCase
    implements
        BaseUsecase<BaseResponseEntity<UserResponseEntity>,
            UpdateProfileRequestEntity> {
  UpdateProfileUseCase({
    required this.baseProfileRepo,
  });

  BaseProfileRepo baseProfileRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<UserResponseEntity>>> call(
    UpdateProfileRequestEntity updateProfileRequestEntity,
  ) async {
    return await baseProfileRepo.updateUserProfile(
      updateProfileRequestEntity: updateProfileRequestEntity,
    );
  }
}
