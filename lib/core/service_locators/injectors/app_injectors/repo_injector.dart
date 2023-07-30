import 'package:shop_app_clean_architecture/core/service_locators/index.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// This class is responsible for injecting repository modules into the service locator.
/// It implements the [BaseInjector] interface.
class RepositoryInjector implements BaseInjector {
  /// TODO: Inject Mappers In UtilInjector Class And Use Them In Here

  /// A list of functions that register the repository implementations into the service locator.
  final _repositoryInjectorList = [
    // Registering AddressRepoImpl
    () => diInstance.registerLazySingleton<BaseAddressRepo>(
          () => AddressRepoImpl(
            baseShopRemoteDataSource: diInstance.get<BaseShopRemoteDS>(),
            baseListResponseMapper: BaseListResponseMapper<AddressResponseModel,
                AddressResponseEntity>(
              mapper: AddressResponseMapper(),
            ),
            baseResponseMapper:
                BaseResponseMapper<AddressResponseModel, AddressResponseEntity>(
              mapper: AddressResponseMapper(),
            ),
            addAddressRequestMapper: AddAddressRequestMapper(),
          ),
        ),
    // Registering AuthRepoImpl
    () => diInstance.registerLazySingleton<BaseAuthRepo>(
          () => AuthRepoImpl(
            baseUserResponseMapper:
                BaseResponseMapper<UserResponseModel, UserResponseEntity>(
              mapper: UserResponseMapper(),
            ),
            baseLogoutResponseMapper:
                BaseResponseMapper<LogoutResponseModel, LogoutResponseEntity>(
              mapper: LogoutResponseMapper(),
            ),
            baseShopRemoteDataSource: diInstance.get<BaseShopRemoteDS>(),
            loginRequestMapper: LoginRequestMapper(),
            registerRequestMapper: RegisterRequestMapper(),
          ),
        ),
    // Registering LocalStorageImpl
    () => diInstance.registerLazySingleton<BaseLocalStorageRepo>(
          () => LocalStorageImpl(
            appThemeRequestMapper: AppThemeRequestMapper(),
            baseLocalDS: diInstance.get<BaseLocalDS>(),
            saveUserDataRequestMapper: SaveUserDataRequestMapper(),
            userResponseMapper: UserResponseMapper(),
          ),
        ),
    // Registering CartRepoImpl
    () => diInstance.registerLazySingleton<BaseCartRepo>(
          () => CartRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            addToCartRequestMapper: AddToCartRequestMapper(),
            baseCartResponseMapper:
                BaseResponseMapper<CartResponseModel, CartResponseEntity>(
              mapper: CartResponseMapper(),
            ),
            baseCartUpdateResponseMapper: BaseResponseMapper<
                CartUpdateResponseModel, CartUpdateResponseEntity>(
              mapper: CartUpdateResponseMapper(),
            ),
            baseEmptyResponseMapper:
                BaseResponseMapper<EmptyResponseModel, EmptyResponseEntity>(
              mapper: EmptyResponseMapper(),
            ),
            deleteCartRequestMapper: DeleteCartItemRequestMapper(),
            updateCartRequestMapper: UpdateCartRequestMapper(),
            baseCartItemResponseMapper:
                BaseResponseMapper<CartItemModel, CartItem>(
              mapper: CartItemMapper(),
            ),
          ),
        ),
    // Registering CategoryRepoImpl
    () => diInstance.registerLazySingleton<BaseCategoryRepo>(
          () => CategoryRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            baseListCategoryResponseMapper: BaseListResponseMapper<
                CategoryResponseModel, CategoryResponseEntity>(
              mapper: CategoryResponseMapper(),
            ),
            baseListProductResponseMapper: BaseListResponseMapper<
                ProductResponseModel, ProductResponseEntity>(
              mapper: ProductResponseMapper(),
            ),
            categoryProductRequestMapper: CategoryProductsRequestMapper(),
          ),
        ),
    // Registering FavoriteRepoImpl
    () => diInstance.registerLazySingleton<BaseFavoriteRepo>(
          () => FavoriteRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            baseListFavoriteResponseMapper: BaseListResponseMapper<
                FavoriteResponseModel, FavoriteResponseEntity>(
              mapper: FavoriteResponseMapper(),
            ),
            baseToggleFavoriteResponseMapper: BaseResponseMapper<
                ToggleFavoriteResponseModel, ToggleFavoriteResponseEntity>(
              mapper: ToggleFavoriteResponseMapper(),
            ),
            favoriteRequestMapper: FavoriteRequestMapper(),
          ),
        ),
    // Registering HomeRepoImpl
    () => diInstance.registerLazySingleton<BaseHomeRepo>(
          () => HomeRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            baseHomeResponseMapper:
                BaseResponseMapper<HomeResponseModel, HomeResponseEntity>(
              mapper: HomeResponseMapper(),
            ),
          ),
        ),
    // Registering OrderRepoImpl
    () => diInstance.registerLazySingleton<BaseOrderRepo>(
          () => OrderRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            addOrderRequestMapper: AddOrderRequestMapper(),
            baseOrderResponseMapper:
                BaseResponseMapper<OrderResponseModel, OrderResponseEntity>(
              mapper: OrderResponseMapper(),
            ),
            orderDetailsRequestMapper: OrderDetailsRequestMapper(),
            baseOrderDetailsResponseMapper: BaseResponseMapper<
                OrderDetailsResponseModel, OrderDetailsResponseEntity>(
              mapper: OrderDetailsResponseMapper(),
            ),
            baseListOrderResponseMapper:
                BaseListResponseMapper<OrderResponseModel, OrderResponseEntity>(
              mapper: OrderResponseMapper(),
            ),
            emptyResponseMapper:
                BaseResponseMapper<EmptyResponseModel, EmptyResponseEntity>(
              mapper: EmptyResponseMapper(),
            ),
          ),
        ),
    // Registering ProfileRepoImpl
    () => diInstance.registerLazySingleton<BaseProfileRepo>(
          () => ProfileRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            changePasswordRequestMapper: ChangePasswordRequestMapper(),
            baseChangePasswordResponseMapper: BaseResponseMapper<
                ChangePasswordResponseModel, ChangePasswordResponseEntity>(
              mapper: ChangePasswordResponseMapper(),
            ),
            baseUserResponseMapper:
                BaseResponseMapper<UserResponseModel, UserResponseEntity>(
              mapper: UserResponseMapper(),
            ),
            updateProfileRequestMapper: UpdateProfileRequestMapper(),
          ),
        ),
    // Registering SearchRepoImpl
    () => diInstance.registerLazySingleton<BaseSearchRepo>(
          () => SearchRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            baseListProductResponseMapper: BaseListResponseMapper<
                ProductResponseModel, ProductResponseEntity>(
              mapper: ProductResponseMapper(),
            ),
            searchRequestMapper: SearchRequestMapper(),
          ),
        ),
    // Registering ProductDetailsRepoImpl
    () => diInstance.registerLazySingleton<BaseProductDetailsRepo>(
          () => ProductDetailsRepoImpl(
            baseShopRemoteDS: diInstance.get<BaseShopRemoteDS>(),
            productResponseMapper:
                BaseResponseMapper<ProductResponseModel, ProductResponseEntity>(
              mapper: ProductResponseMapper(),
            ),
          ),
        ),

    () => diInstance.registerLazySingleton<NotificationRepo>(
          () => NotificationRepoImpl(),
        ),
  ];

  /// Injects the repository modules into the service locator.
  /// It calls each function in [_repositoryInjectorList] to register the repository implementations.
  @override
  void injectModules() {
    for (final repositoryInjector in _repositoryInjectorList) {
      repositoryInjector.call();
    }
  }
}
