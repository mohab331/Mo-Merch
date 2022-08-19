import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/change_password.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/favorite.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/home.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/logout.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/register.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/search.dart';

import '../entities/category.dart';
import '../entities/login.dart';
import '../usecases/cache/app_theme/toggle_app_theme_usecase.dart';
import '../usecases/cache/user_cached_data/set_cached_user_data_usecase.dart';

abstract class BaseShopRepository {
  //cart
  Future<Either<Failure, String>> addToCart({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, CartResponse>> getCartData({
    String lang = 'en',
    required GetUseCaseParameters parameters,
  });
  Future<Either<Failure, String>> removeFromCart({
    String lang = 'en',
    required DeleteUseCaseParameters parameters,
  });

  Future<Either<Failure, CartUpdateResponse>> updateCart(
      {required UpdateUseCaseParameters parameters, String lang = 'en'});

  //address
  Future<Either<Failure, AddressResponse>> addNewAddress({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });
  Future<Either<Failure, AddressResponse>> deleteAddress({
    String lang = 'en',
    required DeleteUseCaseParameters parameters,
  });

  Future<Either<Failure, GetAddressResponse>> getUserAddress({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, AddressResponse>> updateAddress({
    required UpdateUseCaseParameters parameters,
    String lang = 'en',
  });

  //orders
  Future<Either<Failure, OrderResponse>> createOrder({
    String lang = 'en',
    required AddUseCaseParameters parameters,
  });

  Future<Either<Failure, GetOrderResponse>> getOrders({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  //favorite
  Future<Either<Failure, FavoriteResponse>> getFavoriteData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, Map<String,dynamic>>> toggleFavorite({
    String lang = 'en',
    required AddUseCaseParameters parameters,
  });

  //category
  Future<Either<Failure, CategoryResponse>> getCategoryData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, CategoryDetailsResponse>> getCategoryDetails({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  //authentication
  Future<Either<Failure, RegisterResponse>> registerUser({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, LoginResponse>> loginUser({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, LogoutResponse>> logout({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });

  //user profile
  Future<Either<Failure, ProfileResponse>> getUserProfile({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  Future<Either<Failure, ProfileResponse>> updateUserProfile({
    String lang = 'en',
    required UpdateUseCaseParameters parameters,
  });

  Future<Either<Failure, ChangePasswordResponse>> changeUserPassword({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  });

  // home
  Future<Either<Failure, HomeResponse>> getHomeData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  });

  //search product
  Future<Either<Failure, SearchResponse>> searchProduct(
      {required AddUseCaseParameters parameters, String lang = 'en'});

  // local shared preference
  Future<Either<Failure, bool>> toggleAppTheme({required ToggleAppThemeUsecaseParameters parameters});
  Future<Either<Failure, bool>> setOnBoarding();
  Future<Either<Failure, bool>> setUserData({required SetCachedUserDataUsecaseParameters parameters});

  Either<Failure, dynamic> getAppThemeMode();
  Either<Failure, dynamic> getUserData();
  Either<Failure,  dynamic> getOnBoardingData();

  Future<Either<Failure,dynamic>> clearUserData();
}
