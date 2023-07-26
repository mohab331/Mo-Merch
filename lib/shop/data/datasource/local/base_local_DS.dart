import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// An abstract class representing the local data source for storing and retrieving data.
abstract class BaseLocalDS {
  /// Saves the show on boarding flag to the local storage.
  ///
  /// if it is first time for user show on boarding else save to false
  Future<void> saveShowOnBoarding({
    required bool data,
  });

  /// Retrieves the show onboarding flag from the local storage.
  Future<bool?> getShowOnBoarding();

  /// Saves the app theme mode to the local storage.[light] or [dark]
  Future<void> saveThemeMode({
    required AppThemeRequestModel appThemeRequestModel,
  });

  /// Retrieves the current app theme mode from the local storage.[light] or [dark]
  Future<bool?> getAppThemeMode();

  /// Saves the user data to the local storage. [token] and [name]
  Future<void> saveUserData({
    required SaveUserDataRequestModel saveUserDataRequestModel,
  });

  /// Retrieves the user data from the local storage.
  Future<UserResponseModel?> getUserData();

  /// Clears the saved user data from the local storage.
  Future<void> clearSavedUserData();
}

/// A concrete implementation of the [BaseLocalDS] abstract class.
class BaseLocalDSImpl implements BaseLocalDS {
  const BaseLocalDSImpl({
    required this.localStorageConsumer,
  });
  final BaseSecureStorageConsumer localStorageConsumer;

  /// Saves data to the local storage using [cacheConsumer].
  Future<void> _saveDataToLocalStorage({
    required String key,
    required data,
  }) async {
    return localStorageConsumer.setData(
      key: key,
      data: data,
    );
  }

  @override
  Future<bool?> getAppThemeMode() async {
    final response = await localStorageConsumer.getData(
      key: SecureStorageConstants.appTheme,
    );
    return response.toBool();
  }

  @override
  Future<bool?> getShowOnBoarding() async {
    final response = await localStorageConsumer.getData(
      key: SecureStorageConstants.onBoarding,
    );
    return response.toBool();
  }

  @override
  Future<UserResponseModel?> getUserData() async {
    final response = await localStorageConsumer.getData(
      key: SecureStorageConstants.userData,
    );
    if (response == null) {
      return null;
    }
    return const UserResponseModel().fromJson(
      response.toMap(),
    );
  }

  @override
  Future<void> saveShowOnBoarding({required bool data}) async =>
      _saveDataToLocalStorage(
        key: SecureStorageConstants.onBoarding,
        data: data,
      );

  @override
  Future<void> saveUserData({
    required SaveUserDataRequestModel saveUserDataRequestModel,
  }) async =>
      _saveDataToLocalStorage(
        key: SecureStorageConstants.userData,
        data: saveUserDataRequestModel.toJson(),
      );

  @override
  Future<void> saveThemeMode({
    required AppThemeRequestModel appThemeRequestModel,
  }) async =>
      _saveDataToLocalStorage(
        key: SecureStorageConstants.appTheme,
        data: appThemeRequestModel.isDarkTheme.value,
      );

  @override
  Future<void> clearSavedUserData() async {
    return localStorageConsumer.clearUserData(
      key: SecureStorageConstants.userData,
    );
  }
}
