import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetAppThemeUseCase {
  GetAppThemeUseCase({required this.baseLocalStorageRepo});

  BaseLocalStorageRepo baseLocalStorageRepo;

  Either<Failure, dynamic> call() {
    return baseLocalStorageRepo.getAppThemeMode();
  }
}
