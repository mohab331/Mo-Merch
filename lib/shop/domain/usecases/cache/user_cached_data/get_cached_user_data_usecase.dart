import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCachedUserDataUsecase
    implements BaseUsecase<UserResponseEntity?, NoParameters> {
  GetCachedUserDataUsecase({required this.baseLocalStorageRepo});

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, UserResponseEntity?>> call(
      NoParameters parameters,) async {
    return baseLocalStorageRepo.getUserData();
  }
}
