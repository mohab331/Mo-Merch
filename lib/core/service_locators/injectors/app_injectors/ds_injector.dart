import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';
import 'package:shop_app_clean_architecture/core/service_locators/service_locator.dart';

import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/data/repository/cache/index.dart';

/// This class is responsible for injecting data source modules into the service locator.
/// It implements the [BaseInjector] interface.
class DataSourceInjector implements BaseInjector {

  /// A list of functions that register the data source implementations into the service locator.
  final _dataSourceInjectorList = [
        () => diInstance.registerLazySingleton<BaseShopRemoteDS>(
          () => ShopRemoteDSImpl(
        apiConsumer: diInstance.get<ApiConsumer>(),
      ),
    ),
        () => diInstance.registerLazySingleton<BaseLocalDS>(
          () => BaseLocalDSImpl(
        localStorageConsumer: diInstance.get<BaseSecureStorageConsumer>(),
      ),
    ),
  ];

  /// Injects the data source modules into the service locator.
  /// It calls each function in [_dataSourceInjectorList] to register the data source implementations.
  @override
  void injectModules() {
    for (final datasourceInjector in _dataSourceInjectorList) {
      datasourceInjector.call();
    }
  }
}
