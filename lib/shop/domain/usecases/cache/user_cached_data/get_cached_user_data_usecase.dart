import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCachedUserDataUsecase {
  GetCachedUserDataUsecase({required this.baseLocalStorageRepo});

  BaseLocalStorageRepo baseLocalStorageRepo;

  Either<Failure, dynamic> call() {
    return baseLocalStorageRepo.getUserData();
  }
}
