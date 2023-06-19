
import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';

class UsecaseInjector implements BaseInjector {
  final _usecasesInjectorsList = [
  ];

  @override
  void injectModules() {
    for (final usecaseInjector in _usecasesInjectorsList) {
      usecaseInjector.call();
    }
  }
}
