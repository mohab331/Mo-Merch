
import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/exception.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/network/network_checker.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/local/base_shop_local_data_source.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/change_password.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/favorite.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/home.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/login.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/logout.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/register.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/search.dart';
import 'package:shop_app_clean_architecture/shop/domain/repository/base_shop_repository.dart';

import '../../domain/usecases/cache/app_theme/toggle_app_theme_usecase.dart';
import '../../domain/usecases/cache/user_cached_data/set_cached_user_data_usecase.dart';
import '../datasource/remote/base_shop_remote_data_source.dart';

class ShopRepository implements BaseShopRepository {
  final BaseShopRemoteDataSource baseShopRemoteDataSource;
  final BaseShopLocalDataSource baseShopLocalDataSource;
  final NetworkChecker network;

  ShopRepository({
    required this.baseShopRemoteDataSource,
    required this.baseShopLocalDataSource,
    required this.network,
  });

  @override
  Future<Either<Failure, String>> addToCart({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.addToCart(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ChangePasswordResponse>> changeUserPassword({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.changeUserPassword(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, OrderResponse>> createOrder({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.createOrder(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AddressResponse>> deleteAddress({
    required DeleteUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.deleteAddress(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Either<Failure, dynamic> getAppThemeMode() {
    try {
      final response = baseShopLocalDataSource.getAppThemeMode(
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          failureMessage: e.errorMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CartResponse>> getCartData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getCartData(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(failureMessage: e.errorModel.errorMessage));
      }
    } else {
      return const Left(ServerFailure(failureMessage: AppStrings.errorLoading));
    }
  }

  @override
  Future<Either<Failure, CategoryResponse>> getCategoryData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getCategoryData(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          page: parameters.page!,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CategoryDetailsResponse>> getCategoryDetails({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getCategoryDetails(
            url: parameters.url,
            token: parameters.token!,
            lang: lang,
            page: parameters.page!);
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, FavoriteResponse>> getFavoriteData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getFavoriteData(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          page: parameters.page!,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, OrderDetailsResponse>> getOrderDetails({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getOrderDetails(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,

        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, GetOrderResponse>> getOrders({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getOrders(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          page: parameters.page!,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, GetAddressResponse>> getUserAddress({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        try {
          final response = await baseShopRemoteDataSource.getUserAddress(
              url: parameters.url,
              token: parameters.token!,
              lang: lang,
              page: parameters.page!);
          return Right(response);
        } on ServerException catch (e) {
          return Left(
            ServerFailure(
              failureMessage: e.errorModel.errorMessage,
            ),
          );
        }
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Either<Failure, dynamic> getUserData() {
    try {
      final response = baseShopLocalDataSource.getUserData();
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(failureMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> getUserProfile(
      {required GetUseCaseParameters parameters, String lang = 'en'}) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getUserProfile(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, LoginResponse>> loginUser({
    String lang = 'en',
    required AddUseCaseParameters parameters,
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.loginUser(
          url: parameters.url,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.logout(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(failureMessage: e.errorModel.errorMessage));
      }
    } else {
      return const Left(ServerFailure(failureMessage: AppStrings.errorLoading));
    }
  }

  @override
  Future<Either<Failure, RegisterResponse>> registerUser({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.registerUser(
          url: parameters.url,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> removeFromCart({
    required DeleteUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.removeFromCart(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> searchProduct({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.searchProduct(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> toggleAppTheme(
      {required ToggleAppThemeUsecaseParameters parameters}) async {
    try {
      final response = await baseShopLocalDataSource.toggleAppTheme(
        data: parameters.theme,
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(CacheFailure(failureMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> toggleFavorite({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.toggleFavorite(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AddressResponse>> updateAddress({
    String lang = 'en',
    required UpdateUseCaseParameters parameters,
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.updateAddress(
          url: parameters.url,
          data: parameters.data,
          lang: lang,
          token: parameters.token,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CartUpdateResponse>> updateCart({
    required UpdateUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.updateCart(
          url: parameters.url,
          data: parameters.data,
          lang: lang,
          token: parameters.token,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ProfileResponse>> updateUserProfile({
    required UpdateUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.updateUserProfile(
          url: parameters.url,
          data: parameters.data,
          lang: lang,
          token: parameters.token,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AddressResponse>> addNewAddress({
    required AddUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.addNewAddress(
          url: parameters.url,
          token: parameters.token!,
          lang: lang,
          data: parameters.data,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, HomeResponse>> getHomeData({
    required GetUseCaseParameters parameters,
    String lang = 'en',
  }) async {
    if (await network.isConnected) {
      try {
        final response = await baseShopRemoteDataSource.getHomeData(
          url: parameters.url,
          lang: lang,
          token: parameters.token!
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(
            failureMessage: e.errorModel.errorMessage,
          ),
        );
      }
    } else {
      return const Left(
        ServerFailure(
          failureMessage: AppStrings.errorLoading,
        ),
      );
    }
  }

  @override
  Either<Failure, dynamic> getOnBoardingData() {
    try {
      final response = baseShopLocalDataSource.getOnBoarding(
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          failureMessage: e.errorMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> setOnBoarding() async {
    try {
      final response = await baseShopLocalDataSource.setOnBoarding(
        data: true,
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          failureMessage: e.errorMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure,dynamic>> clearUserData()async{
     try {
       final response = await baseShopLocalDataSource.clearUserData();
       return Right(response);
     } on CacheException catch (e) {
       return Left(CacheFailure(failureMessage: e.errorMessage));
     }
  }

  @override
  Future<Either<Failure, bool>> setUserData(
      {required SetCachedUserDataUsecaseParameters parameters}) async {
    try {
      final response = await baseShopLocalDataSource.setUserData(
        data: {
          'token': parameters.token,
          'name': parameters.name,
        },
      );
      return Right(response);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          failureMessage: e.errorMessage,
        ),
      );
    }
  }
}
