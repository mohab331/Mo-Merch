import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class BaseLocalStorageRepo {
  Future<Either<Failure, bool>> toggleAppTheme(
      {required AppThemeRequestEntity appThemeRequestEntity,});

  Future<Either<Failure, bool>> setOnBoarding();

  Future<Either<Failure, bool>> setUserData(
      {required SaveUserDataRequestEntity saveUserDataRequestEntity,});

  Either<Failure, dynamic> getAppThemeMode();

  Either<Failure, dynamic> getUserData();

  Either<Failure, dynamic> getOnBoardingData();

  Future<Either<Failure, dynamic>> clearUserData();
}
