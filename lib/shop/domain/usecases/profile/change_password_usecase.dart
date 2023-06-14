import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ChangePasswordUsecase
    implements
        BaseUsecase<BaseResponseEntity<ChangePasswordResponseEntity>,
            ChangePasswordRequestEntity> {
  ChangePasswordUsecase({required this.baseProfileRepo});

  BaseProfileRepo baseProfileRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<ChangePasswordResponseEntity>>>
      call(
    ChangePasswordRequestEntity changePasswordRequestEntity,
  ) async {
    return await baseProfileRepo.changeUserPassword(
      changePasswordRequestEntity: changePasswordRequestEntity,
    );
  }
}
