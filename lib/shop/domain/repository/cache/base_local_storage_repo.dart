import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/enums/app_theme_enum.dart';

/// The abstract class `BaseLocalStorageRepo` defines the interface for interacting
/// with the local storage to perform various operations related to app theme,
/// onboarding data, user data, and clearing user data.
abstract class BaseLocalStorageRepo {
  /// Toggles the app theme between light and dark based on the provided
  /// `appThemeRequestEntity`.
  ///
  /// Returns a `Future` that completes with an `Either` containing a `Failure`
  /// object in case of any errors, or a `bool` value indicating the success
  /// of the operation.
  Future<Either<Failure, bool>> toggleAppTheme({
    required AppThemeRequestEntity appThemeRequestEntity,
  });

  /// Sets the onboarding data in the local storage.
  ///
  /// Returns a `Future` that completes with an `Either` containing a `Failure`
  /// object in case of any errors, or a `bool` value indicating the success
  /// of the operation.
  Future<Either<Failure, bool>> setOnBoarding({required bool showOnBoarding,});

  /// Sets the user data in the local storage based on the provided
  /// `saveUserDataRequestEntity`.
  ///
  /// Returns a `Future` that completes with an `Either` containing a `Failure`
  /// object in case of any errors, or a `bool` value indicating the success
  /// of the operation.
  Future<Either<Failure, bool>> setUserData({
    required SaveUserDataRequestEntity saveUserDataRequestEntity,
  });

  /// Retrieves the app theme mode from the local storage.
  ///
  /// Returns an `Either` containing a `Failure` object in case of any errors,
  /// or a `AppThemeEnum` value representing the app theme mode.
  Future<Either<Failure, AppThemeEnum>> getAppThemeMode();

  /// Retrieves the user data from the local storage.
  ///
  /// Returns an `Either` containing a `Failure` object in case of any errors,
  /// or a `dynamic` value representing the user data.
  Future<Either<Failure, UserDataResponseEntity>> getUserData();

  /// Retrieves the onBoarding data from the local storage.
  ///
  /// Returns an `Either` containing a `Failure` object in case of any errors,
  /// or a `bool?` value representing the onboarding data.
  Future<Either<Failure, bool>> getOnBoardingData();

  /// Clears the user data from the local storage.
  ///
  /// Returns a `Future` that completes with an `Either` containing a `Failure`
  /// object in case of any errors, or a success
  /// of the operation.
  Future<Either<Failure, bool>> clearUserData();
}
