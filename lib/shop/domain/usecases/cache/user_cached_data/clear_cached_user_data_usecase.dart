import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ClearCachedUserDataUsecase implements BaseUsecase<dynamic, NoParameters> {
  ClearCachedUserDataUsecase({
    required this.baseLocalStorageRepo,
  });

  BaseLocalStorageRepo baseLocalStorageRepo;

  @override
  Future<Either<Failure, dynamic>> call(NoParameters parameters) async {
    return baseLocalStorageRepo.clearUserData();
  }
}
