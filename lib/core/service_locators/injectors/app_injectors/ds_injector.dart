import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';

class DataSourceInjector implements BaseInjector {
  final _dataSourceInjectorList = [
  ];

  @override
  void injectModules() {
    for (final datasourceInjector in _dataSourceInjectorList) {
      datasourceInjector.call();
    }
  }
}
