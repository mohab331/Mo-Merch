import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app_clean_architecture/core/service_locators/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';

final diInstance = GetIt.instance;

class ServiceLocator {
  Future<void> init() async {
    const flutterSecureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions.defaultOptions,
    );
    diInstance..registerLazySingleton<FlutterSecureStorage>(() => flutterSecureStorage,)
    ..registerLazySingleton<ApiConsumer>(() =>  DioConsumer(dio: Dio(),),)
    ..registerLazySingleton<BaseSecureStorageConsumer>(() => SecureStorageConsumer(secureStorage: diInstance.get<FlutterSecureStorage>(),),);

    InjectorHolder.injectAllModules();
  }
}
