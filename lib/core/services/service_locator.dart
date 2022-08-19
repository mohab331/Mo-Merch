import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_clean_architecture/core/api/api_consumer.dart';
import 'package:shop_app_clean_architecture/core/api/dio_consumer.dart';
import 'package:shop_app_clean_architecture/core/cache/cache_consumer.dart';
import 'package:shop_app_clean_architecture/core/cache/shared_preference_consumer.dart';
import 'package:shop_app_clean_architecture/core/network/network_checker.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/local/base_shop_local_data_source.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/remote/base_shop_remote_data_source.dart';
import 'package:shop_app_clean_architecture/shop/data/repository/shop_repository.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/base_shop_repository.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/add_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/delete_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/get_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/address/update_address_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/app_theme/get_app_theme_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/app_theme/toggle_app_theme_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cache/user_cached_data/clear_cached_user_data_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/add_to_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/get_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/update_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/category/get_category_products_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/category/get_category_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/get_favorite_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/favorite/toggle_favorite_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/home/get_home_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/login/login_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/logout/logout_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/order/add_order_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/order/get_order_details_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/change_password_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/get_profile_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/profile/update_profile_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/register/register_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/search/search_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/address/address_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/cart/cart_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/category/category_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/check_out/check_out_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/favorite/favorite_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/home/home_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/login/login_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/order/order_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/product_description/product_description_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/profile/profile_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/register/register_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/search/search_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';
import '../../shop/domain/usecases/cache/on_boarding/get_on_boarding_usecase.dart';
import '../../shop/domain/usecases/cache/on_boarding/set_on_boarding_usecase.dart';
import '../../shop/domain/usecases/cache/user_cached_data/get_cached_user_data_usecase.dart';
import '../../shop/domain/usecases/cache/user_cached_data/set_cached_user_data_usecase.dart';
import '../../shop/domain/usecases/order/get_order_usecase.dart';

final sl =GetIt.instance;
class ServiceLocator{
init() async{
 // repository
  sl.registerLazySingleton<BaseShopRepository>(() => ShopRepository(baseShopRemoteDataSource: sl(), baseShopLocalDataSource: sl(), network: sl(),),);

  // datasource
  sl.registerLazySingleton<BaseShopRemoteDataSource>(() => ShopRemoteDataSourceImplementation(apiConsumer: sl()));
  sl.registerLazySingleton<BaseShopLocalDataSource>(() => ShopLocalDataSourceImplementation(cacheConsumer: sl()));


  //consumer
  Dio dio = Dio();
  // can see what is sent and received from api
  sl.registerLazySingleton(() => LogInterceptor(
    request: true,
    requestBody: true,
    requestHeader: true,
    responseBody: true,
    responseHeader: true,
  ));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: dio));
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<CacheConsumer>(() => SharedPreferenceConsumer(sharedPreferences: sl(),),);

  //network
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkChecker>(() => NetworkCheckerImplementation(sl()));

  // usecases
  //address
  sl.registerLazySingleton(() => AddNewAddressUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => DeleteAddressUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetAddressUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => UpdateAddressUseCase(baseShopRepository: sl()));

  //cache
  sl.registerLazySingleton(() => GetAppThemeUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => ToggleAppThemeUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetOnBoardingUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => SetOnBoardingUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetCachedUserDataUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => SetCachedUserDataUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => ClearCachedUserDataUsecase(baseShopRepository: sl()));

  //cart
  sl.registerLazySingleton(() => AddToCartUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => DeleteCartUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetCartUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(baseShopRepository: sl()));

  //category
  sl.registerLazySingleton(() => GetCategoryProductsUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetCategoryUsecase(baseShopRepository: sl()));

  //favorite
  sl.registerLazySingleton(() => GetFavoriteUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUsecase(baseShopRepository: sl()));

  //home
  sl.registerLazySingleton(() => GetHomeUsecase(baseShopRepository: sl()));

  //login
  sl.registerLazySingleton(() => LoginUsecase(baseShopRepository: sl()));

  //register
  sl.registerLazySingleton(() => RegisterUsecase(baseShopRepository: sl()));

  //logout
  sl.registerLazySingleton(() => LogoutUsecase(baseShopRepository: sl()));

  //order
  sl.registerLazySingleton(() => AddOrderUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetOrderUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetOrderDetailsUsecase(baseShopRepository: sl()));

  //profile
  sl.registerLazySingleton(() => ChangePasswordUsecase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(baseShopRepository: sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(baseShopRepository: sl()));

  //search
  sl.registerLazySingleton(() => SearchUseCase(baseShopRepository: sl()));


  //cubit
  sl.registerFactory(() => OnBoardingCubit());
  sl.registerFactory(() => AppCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => ShopCubit());
  sl.registerFactory(() => HomeCubit());
  sl.registerFactory(() => ProductDescriptionCubit());
  sl.registerFactory(() => CartCubit());
  sl.registerFactory(() => CategoryCubit());
  sl.registerFactory(() => FavoriteCubit());
  sl.registerFactory(() => SearchCubit());
  sl.registerFactory(() => ProfileCubit());
  sl.registerFactory(() => OrderCubit());
  sl.registerFactory(() => AddressCubit());
  sl.registerFactory(() => CheckOutCubit());



}
}