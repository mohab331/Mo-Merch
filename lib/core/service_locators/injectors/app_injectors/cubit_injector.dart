import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CubitInjector implements BaseInjector {
  final _cubitInjectorsList = [
    () => diInstance.registerFactory<OnBoardingCubit>(
          () => OnBoardingCubit(
            setOnBoardingUsecase: diInstance.get<SetOnBoardingUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<AuthCubit>(
          () => AuthCubit(
            loginUsecase: diInstance.get<LoginUsecase>(),
            logoutUsecase: diInstance.get<LogoutUsecase>(),
            registerUsecase: diInstance.get<RegisterUsecase>(),
            getCachedUserDataUsecase:
                diInstance.get<GetCachedUserDataUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<HomeCubit>(
          () => HomeCubit(
            getHomeUsecase: diInstance.get<GetHomeUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<LoginCubit>(
          () => LoginCubit(),
        ),
    () => diInstance.registerFactory<SplashCubit>(
          () => SplashCubit(
            getAppThemeUseCase: diInstance.get<GetAppThemeUseCase>(),
            getOnBoardingUsecase: diInstance.get<GetOnBoardingUsecase>(),
            getCachedUserDataUsecase:
                diInstance.get<GetCachedUserDataUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<ShopCubit>(
          () => ShopCubit(),
        ),
    () => diInstance.registerFactory<SearchCubit>(
          () => SearchCubit(
            searchUseCase: diInstance.get<SearchUseCase>(),
          ),
        ),
    () => diInstance.registerFactory<CartCubit>(
          () => CartCubit(
            addToCartUseCase: diInstance.get<AddToCartUseCase>(),
            deleteCartUseCase: diInstance.get<DeleteCartUseCase>(),
            getCartUseCase: diInstance.get<GetCartUseCase>(),
            updateCartUsecase: diInstance.get<UpdateCartUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<ProductDetailsCubit>(
          () => ProductDetailsCubit(
            productDetailsUc: diInstance.get<GetProductDetailsUc>(),
          ),
        ),
    () => diInstance.registerFactory<CategoryCubit>(
          () => CategoryCubit(
            getCategoryUsecase: diInstance.get<GetCategoryUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<CategoryProductsCubit>(
          () => CategoryProductsCubit(
            getCategoryProductsUsecase:
                diInstance.get<GetCategoryProductsUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<ProfileCubit>(
          () => ProfileCubit(
            getProfileUseCase: diInstance.get<GetProfileUseCase>(),
          ),
        ),
    () => diInstance.registerFactory<ChangePasswordCubit>(
          () => ChangePasswordCubit(
            changePasswordUsecase: diInstance.get<ChangePasswordUsecase>(),
          ),
        ),
    () => diInstance.registerFactory<EditPersonalDataCubit>(
          () => EditPersonalDataCubit(
            updateProfileUseCase: diInstance.get<UpdateProfileUseCase>(),
          ),
        ),
    () => diInstance.registerFactory<FavoriteCubit>(
          () => FavoriteCubit(
            getFavoriteUsecase: diInstance.get<GetFavoriteUsecase>(),
            toggleFavoriteUsecase: diInstance.get<ToggleFavoriteUsecase>(),
          ),
        ),
        () => diInstance.registerFactory<AppCubit>(
          () => AppCubit(
        getFavoriteUsecase: diInstance.get<GetFavoriteUsecase>(),
      ),
    ),
  ];

  @override
  void injectModules() {
    for (final cubitInjector in _cubitInjectorsList) {
      cubitInjector.call();
    }
  }
}
