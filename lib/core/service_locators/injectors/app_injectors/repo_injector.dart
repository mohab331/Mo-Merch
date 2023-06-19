import 'package:shop_app_clean_architecture/core/service_locators/injectors/index.dart';

class RepositoryInjector implements BaseInjector {
  final _repositoryInjectorList = [
  ];

  @override
  void injectModules() {
    for (final repositoryInjector in _repositoryInjectorList) {
      repositoryInjector.call();
    }
  }
}
