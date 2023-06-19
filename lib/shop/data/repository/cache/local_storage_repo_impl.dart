import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class LocalStorageImpl implements BaseLocalStorageRepo {
  @override
  Future<Either<Failure, dynamic>> clearUserData() {
    // TODO: implement clearUserData
    throw UnimplementedError();
  }

  @override
  Either<Failure, dynamic> getAppThemeMode() {
    // TODO: implement getAppThemeMode
    throw UnimplementedError();
  }

  @override
  Either<Failure, dynamic> getOnBoardingData() {
    // TODO: implement getOnBoardingData
    throw UnimplementedError();
  }

  @override
  Either<Failure, dynamic> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> setOnBoarding() {
    // TODO: implement setOnBoarding
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> setUserData({
    required SaveUserDataRequestEntity saveUserDataRequestEntity,
  }) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> toggleAppTheme({
    required AppThemeRequestEntity appThemeRequestEntity,
  }) {
    // TODO: implement toggleAppTheme
    throw UnimplementedError();
  }
}
