import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';

class CubitInjector implements BaseInjector {
  final _cubitInjectorsList = [];

  @override
  void injectModules() {
    for (final cubitInjector in _cubitInjectorsList) {
      cubitInjector.call();
    }
  }
}
