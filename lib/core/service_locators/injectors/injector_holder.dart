import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';

class InjectorHolder {
  static final _applicationInjectorsList = [
    DataSourceInjector(),
    RepositoryInjector(),
    UsecaseInjector(),
    CubitInjector(),
  ];

  static void injectAllModules() {
    for (final appInjector in _applicationInjectorsList) {
      appInjector.injectModules();
    }
  }
}
