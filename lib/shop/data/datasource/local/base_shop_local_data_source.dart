import 'package:shop_app_clean_architecture/core/error/exception.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/local/cache/local_storage_constants.dart';

import 'package:shop_app_clean_architecture/shop/data/datasource/local/cache/base_local_storage_consumer.dart';

/// An abstract class representing the local data source for storing and retrieving data.
abstract class BaseLocalDS {
  /// Saves the show on boarding flag to the local storage.
  ///
  /// if it is first time for user show on boarding else save to false
  Future<bool> saveShowOnBoarding({
    required bool data,
  });

  /// Retrieves the show onboarding flag from the local storage.
  bool getShowOnBoarding();

  /// Saves the app theme mode to the local storage.[light] or [dark]
  Future<bool> saveThemeMode({
    required bool data,
  });

  /// Retrieves the current app theme mode from the local storage.[light] or [dark]
  bool getAppThemeMode();

  /// Saves the user data to the local storage. [token] and [name]
  Future<bool> saveUserData({
    required Map<String, dynamic> data,
  });

  /// Retrieves the user data from the local storage.
  Map<String, dynamic> getUserData();

  /// Clears the saved user data from the local storage.
  Future<void> clearSavedUserData();
}

/// A concrete implementation of the [BaseLocalDS] abstract class.
class BaseLocalDSImpl implements BaseLocalDS {
  const BaseLocalDSImpl({
    required this.localStorageConsumer,
  });
  final BaseAppLocalStorageConsumer localStorageConsumer;

  /// Saves data to the local storage using [cacheConsumer].
  Future<bool> _saveDataToLocalStorage({
    required String key,
    required data,
  }) async {
    return await localStorageConsumer
        .setData(key: key, data: data)
        .onError((error, stackTrace) {
      throw CacheException(errorMessage: error.toString());
    });
  }

  @override
  bool getAppThemeMode() {
    return localStorageConsumer.getData(
      key: LocalStorageConstants.appTheme,
    ) as bool;
  }

  @override
  bool getShowOnBoarding() => localStorageConsumer.getData(
    key: LocalStorageConstants.onBoarding,
  );

  @override
  Map<String, dynamic> getUserData() => localStorageConsumer.getData(
    key: LocalStorageConstants.userData,
  ) as Map<String, dynamic>;

  @override
  Future<bool> saveShowOnBoarding({required bool data}) async =>
      _saveDataToLocalStorage(
        key: LocalStorageConstants.onBoarding,
        data: data,
      );

  @override
  Future<bool> saveUserData({required Map<String, dynamic> data}) async =>
      _saveDataToLocalStorage(
        key: LocalStorageConstants.userData,
        data: data,
      );

  @override
  Future<bool> saveThemeMode({required bool data}) async =>
      _saveDataToLocalStorage(
        key: LocalStorageConstants.appTheme,
        data: data,
      );

  @override
  Future<void> clearSavedUserData() async {
    return await localStorageConsumer
        .clearUserData(
      key: LocalStorageConstants.userData,
    ).onError((error, stackTrace) {
      throw CacheException(
        errorMessage: error.toString(),
      );
    });
  }
}
