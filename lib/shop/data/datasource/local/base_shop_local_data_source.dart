import 'package:shop_app_clean_architecture/core/cache/cache_consumer.dart';
import 'package:shop_app_clean_architecture/core/cache/shared_preference_constants.dart';
import 'package:shop_app_clean_architecture/core/error/exception.dart';

abstract class BaseShopLocalDataSource {
  Future<bool> setOnBoarding({
    required data,
  });

  dynamic getAppThemeMode();

  Future<bool> toggleAppTheme({
    required data,
  });

  Future<bool> setUserData({
    required data,
  });

  dynamic getUserData();

  dynamic getOnBoarding();

  Future<bool> clearUserData();
}

class ShopLocalDataSourceImplementation implements BaseShopLocalDataSource {
  CacheConsumer cacheConsumer;
  ShopLocalDataSourceImplementation({required this.cacheConsumer});

  @override
  dynamic getAppThemeMode() {
    return cacheConsumer.getData(
      key: SharedPreferenceConstants.appTheme,
    );
  }

  @override
  dynamic getUserData() {
    return cacheConsumer.getData(
      key: SharedPreferenceConstants.userData,
    );
  }

  @override
  Future<bool> setOnBoarding({required data}) async {
    return await cacheConsumer
        .setData(key: SharedPreferenceConstants.onBoarding, data: data)
        .onError((error, stackTrace) {
      throw CacheException(errorMessage: error.toString());
    });
  }

  @override
  Future<bool> setUserData({required data}) async {
    return await cacheConsumer
        .setData(key: SharedPreferenceConstants.userData, data: data)
        .onError((error, stackTrace) {
      throw CacheException(errorMessage: error.toString());
    });
  }

  @override
  Future<bool> toggleAppTheme({required data}) async {
    return await cacheConsumer
        .setData(key: SharedPreferenceConstants.appTheme, data: data)
        .onError((error, stackTrace) {
      throw CacheException(errorMessage: error.toString());
    });
  }

  @override
  Future<bool> clearUserData() async {
    return await cacheConsumer
        .clearUserData(key: SharedPreferenceConstants.userData)
        .onError((error, stackTrace) {
      throw CacheException(errorMessage: error.toString());
    });
  }

  @override
  getOnBoarding() {
    return cacheConsumer.getData(key: SharedPreferenceConstants.onBoarding,);
  }
}
