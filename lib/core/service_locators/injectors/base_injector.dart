/// The base abstract class for dependency injection module injectors.
/// Implementing classes should provide the `injectModules` method for registering modules into the dependency injection container.
abstract class BaseInjector {
  /// Injects the modules into the dependency injection container.
  void injectModules();
}
