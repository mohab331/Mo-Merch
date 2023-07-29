import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// The injector class responsible for registering the use cases into the dependency injection container.
class UsecaseInjector implements BaseInjector {
  /// The list of injector functions for registering the use cases.

  final _usecasesInjectorsList = [
    () => diInstance.registerLazySingleton<AddNewAddressUseCase>(
          () => AddNewAddressUseCase(
            baseAddressRepo: diInstance.get<BaseAddressRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetAddressUseCase>(
          () => GetAddressUseCase(
            baseAddressRepo: diInstance.get<BaseAddressRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<LoginUsecase>(
          () => LoginUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<RegisterUsecase>(
          () => RegisterUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<LogoutUsecase>(
          () => LogoutUsecase(
            baseAuthRepo: diInstance.get<BaseAuthRepo>(),
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetAppThemeUseCase>(
          () => GetAppThemeUseCase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ClearCachedUserDataUsecase>(
          () => ClearCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SetCachedUserDataUsecase>(
          () => SetCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SetOnBoardingUsecase>(
          () => SetOnBoardingUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetOnBoardingUsecase>(
          () => GetOnBoardingUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ToggleAppThemeUseCase>(
          () => ToggleAppThemeUseCase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetCachedUserDataUsecase>(
          () => GetCachedUserDataUsecase(
            baseLocalStorageRepo: diInstance.get<BaseLocalStorageRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<AddToCartUseCase>(
          () => AddToCartUseCase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetCartUseCase>(
          () => GetCartUseCase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<DeleteCartUseCase>(
          () => DeleteCartUseCase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UpdateCartUsecase>(
          () => UpdateCartUsecase(
            baseCartRepo: diInstance.get<BaseCartRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetCategoryUsecase>(
          () => GetCategoryUsecase(
            baseCategoryRepo: diInstance.get<BaseCategoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetCategoryProductsUsecase>(
          () => GetCategoryProductsUsecase(
            baseCategoryRepo: diInstance.get<BaseCategoryRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetFavoriteUsecase>(
          () => GetFavoriteUsecase(
            baseFavoriteRepo: diInstance.get<BaseFavoriteRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ToggleFavoriteUsecase>(
          () => ToggleFavoriteUsecase(
            baseFavoriteRepo: diInstance.get<BaseFavoriteRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetHomeUsecase>(
          () => GetHomeUsecase(
            baseHomeRepo: diInstance.get<BaseHomeRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<AddOrderUseCase>(
          () => AddOrderUseCase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<EditOrderUseCase>(
          () => EditOrderUseCase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetOrderDetailsUsecase>(
          () => GetOrderDetailsUsecase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetOrderUsecase>(
          () => GetOrderUsecase(
            baseOrderRepo: diInstance.get<BaseOrderRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<ChangePasswordUsecase>(
          () => ChangePasswordUsecase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetProfileUseCase>(
          () => GetProfileUseCase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<UpdateProfileUseCase>(
          () => UpdateProfileUseCase(
            baseProfileRepo: diInstance.get<BaseProfileRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<SearchUseCase>(
          () => SearchUseCase(
            baseSearchRepo: diInstance.get<BaseSearchRepo>(),
          ),
        ),
    () => diInstance.registerLazySingleton<GetProductDetailsUc>(
          () => GetProductDetailsUc(
            baseProductDetailsRepo: diInstance.get<BaseProductDetailsRepo>(),
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
