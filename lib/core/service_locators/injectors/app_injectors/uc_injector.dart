import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/core/service_locators/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/order/get_order_usecase.dart';

/// The injector class responsible for registering the use cases into the dependency injection container.
class UsecaseInjector implements BaseInjector {
  /// The list of injector functions for registering the use cases.

  final _usecasesInjectorsList = [
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => AddNewAddressUseCase(
            baseAddressRepo: diInstance.get<BaseAddressRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetAddressUseCase(
            baseAddressRepo: diInstance.get<BaseAddressRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => LoginUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => RegisterUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => LogoutUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetAppThemeUseCase>(
          () => GetAppThemeUseCase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => ClearCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => SetCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => SetOnBoardingUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetOnBoardingUsecase>(
          () => GetOnBoardingUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => ToggleAppThemeUseCase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetCachedUserDataUsecase>(
          () => GetCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => AddToCartUseCase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => DeleteCartUseCase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => UpdateCartUsecase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetCategoryUsecase(
            baseCategoryRepo: diInstance.get<BaseCategoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetCategoryProductsUsecase(
            baseCategoryRepo: diInstance.get<BaseCategoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetFavoriteUsecase(
            baseFavoriteRepo: diInstance.get<BaseFavoriteRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => ToggleFavoriteUsecase(
            baseFavoriteRepo: diInstance.get<BaseFavoriteRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetHomeUsecase(
            baseHomeRepo: diInstance.get<BaseHomeRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => AddOrderUseCase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetOrderDetailsUsecase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetOrderUsecase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => ChangePasswordUsecase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => GetProfileUseCase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => UpdateProfileUseCase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<BaseUsecase>(
          () => SearchUseCase(
            baseSearchRepo: diInstance.get<BaseSearchRepo>(),
          ),
        ),
  ];

  @override
  void injectModules() {
    /// Iterate over the use case injectors and call them to register the use cases
    for (final usecaseInjector in _usecasesInjectorsList) {
      usecaseInjector.call();
    }
  }
}
