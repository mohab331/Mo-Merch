import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SetCachedUserDataUsecase
    implements BaseUsecase<bool, SaveUserDataRequestEntity> {
  SetCachedUserDataUsecase({required this.baseLocalStorageRepo});

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, bool>> call(
    SaveUserDataRequestEntity saveUserDataRequestEntity,
  ) async {
    return await baseLocalStorageRepo.setUserData(
      saveUserDataRequestEntity: saveUserDataRequestEntity,
    );
  }
}
