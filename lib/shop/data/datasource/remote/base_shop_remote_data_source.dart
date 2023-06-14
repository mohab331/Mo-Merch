import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/api/api_consumer.dart';
import 'package:shop_app_clean_architecture/core/error/exception.dart';
import 'package:shop_app_clean_architecture/core/network/error_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/address_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/cart_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/category_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/change_password_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/favorite_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/home_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/login_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/logout_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/order_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/register_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/search_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/update_profile_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/address/address_response_entity.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart/cart_response_entity.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile/change_password_response_entity.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/favorite/favorite_response_entity.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/home/home_response_entity.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/login.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/logout.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/order.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/register.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/search/search_response_entity.dart';

abstract class BaseShopRemoteDataSource {
  //home
  Future<HomeResponse> getHomeData({
    required String url,
    required String lang,
    required String token,
  });
  //Addresses
  Future<AddressResponse> addNewAddress(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});
  Future<AddressResponse> deleteAddress({
    required String url,
    required String token,
    required String lang,
  });
  Future<AddressResponse> updateAddress({
    required String url,
    required Map<String, dynamic> data,
    required String lang,
    required String token,
  });

  Future<GetAddressResponse> getUserAddress({
    required String url,
    required String token,
    required String lang,
    required int page,
  });

  //cart
  Future<String> addToCart(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});
  Future<CartUpdateResponse> updateCart(
      {required String url,
      required Map<String, dynamic> data,
      required String lang,
      required String token});
  Future<CartResponse> getCartData(
      {required String url,
      required String token,
      required String lang,
      });
  Future<String> removeFromCart({
    required String url,
    required String token,
    required String lang,
  });

  //user profile
  Future<ChangePasswordResponse> changeUserPassword(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});
  Future<ProfileResponse> getUserProfile(
      {required String url, required String token, required String lang});
  Future<ProfileResponse> updateUserProfile(
      {required String url,
      required Map<String, dynamic> data,
      required String lang,
      required String token});

  //order
  Future<OrderResponse> createOrder(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});
  Future<OrderDetailsResponse> getOrderDetails(
      {required String url,
      required String token,
      required String lang,
     });
  Future<GetOrderResponse> getOrders(
      {required String url,
      required String token,
      required String lang,
      required int page});

  //category
  Future<CategoryResponse> getCategoryData(
      {required String url,
      required String token,
      required String lang,
      required int page});
  Future<CategoryDetailsResponse> getCategoryDetails(
      {required String url,
      required String token,
      required String lang,
      required int page});

  //favorite
  Future<FavoriteResponse> getFavoriteData(
      {required String url,
      required String token,
      required String lang,
      required int page});
  Future<Map<String, dynamic>> toggleFavorite(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});

  //search
  Future<SearchResponse> searchProduct(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data});

  //register
  Future<RegisterResponse> registerUser(
      {required String url,
      required String lang,
      required Map<String, dynamic> data});

  //login
  Future<LoginResponse> loginUser(
      {required String url,
      required String lang,
      required Map<String, dynamic> data});

  //logout
  Future<LogoutResponse> logout({
    required String url,
    required String token,
    required String lang,
  });
}

class ShopRemoteDataSourceImplementation implements BaseShopRemoteDataSource {
  ApiConsumer apiConsumer;
  ShopRemoteDataSourceImplementation({required this.apiConsumer});

  void _checkError(Response response) {
    if (response.data['status'] == false || response.statusCode != 200) {
      throw ServerException(
          errorModel: ErrorModel.fromJson(jsonMap: response.data));
    }
  }

  @override
  Future<AddressResponse> addNewAddress(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
      url: url,
      data: data,
      lang: lang,
      token: token,
    );
    _checkError(response);
    return AddressResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<String> addToCart(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
        url: url, data: data, token: token, lang: lang);
    _checkError(response);
    return response.data['message'];
  }

  @override
  Future<ChangePasswordResponse> changeUserPassword(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
        url: url, data: data, lang: lang, token: token);
    _checkError(response);
    return ChangePasswordResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<OrderResponse> createOrder(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
        url: url, data: data, token: token, lang: lang);
    _checkError(response);
    return OrderResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<AddressResponse> deleteAddress({
    required String url,
    required String token,
    required String lang,
  }) async {
    final response = await apiConsumer.deleteData(
        url: url, data: {}, lang: lang, token: token);
    _checkError(response);
    return AddressResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<CartResponse> getCartData(
      {required String url,
      required String token,
      required String lang,
      }) async {
    final response = await apiConsumer
        .getData(url: url, token: token, lang: lang, );
    _checkError(response);
    return CartResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<HomeResponse> getHomeData({
    required String url,
    required String lang,
    required String token,
  }) async {
    final response =
        await apiConsumer.getData(url: url, lang: lang, token: token);
    _checkError(response);
    return HomeResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<CategoryResponse> getCategoryData({
    required String url,
    required String token,
    required String lang,
    required int page,
  }) async {
    final response = await apiConsumer
        .getData(url: url, lang: lang, token: token, queryMap: {'page': page});
    _checkError(response);
    return CategoryResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<CategoryDetailsResponse> getCategoryDetails(
      {required String url,
      required String token,
      required String lang,
      required int page}) async {
    final response = await apiConsumer.getData(
      url: url,
      lang: lang,
      token: token,
      queryMap: {'page': page},
    );
    _checkError(response);
    return CategoryDetailsResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<FavoriteResponse> getFavoriteData(
      {required String url,
      required String token,
      required String lang,
      required int page}) async {
    final response = await apiConsumer
        .getData(url: url, token: token, lang: lang, queryMap: {'page': page});
    _checkError(response);
    return FavoriteResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(
      {required String url,
      required String token,
      required String lang,
      }) async {
    final response = await apiConsumer
        .getData(url: url, lang: lang, token: token, );
    _checkError(response);
    return OrderDetailsResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<GetOrderResponse> getOrders(
      {required String url,
      required String token,
      required String lang,
      required int page}) async {
    final response = await apiConsumer
        .getData(url: url, token: token, lang: lang, queryMap: {'page': page});
    _checkError(response);
    return GetOrderResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<GetAddressResponse> getUserAddress(
      {required String url,
      required String token,
      required String lang,
      required int page}) async {
    final response = await apiConsumer
        .getData(url: url, token: token, lang: lang, queryMap: {'page': page});
    _checkError(response);
    return GetAddressResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<ProfileResponse> getUserProfile(
      {required String url,
      required String token,
      required String lang}) async {
    final response =
        await apiConsumer.getData(url: url, token: token, lang: lang);
    _checkError(response);
    return ProfileResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<LoginResponse> loginUser(
      {required String url,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
      url: url,
      data: data,
      lang: lang,
    );
    _checkError(response);
    return LoginResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<LogoutResponse> logout({
    required String url,
    required String token,
    required String lang,
  }) async {
    final response = await apiConsumer.postData(
        url: url, data: {}, lang: lang, token: token);
    _checkError(response);
    return LogoutResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<RegisterResponse> registerUser({
    required String url,
    required String lang,
    required Map<String, dynamic> data,
  }) async {
    final response =
        await apiConsumer.postData(url: url, data: data, lang: lang);
    _checkError(response);
    return RegisterResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<String> removeFromCart({
    required String url,
    required String token,
    required String lang,
  }) async {
    final response =
        await apiConsumer.deleteData(url: url, lang: lang, token: token);
    _checkError(response);
    return response.data['message'];
  }

  @override
  Future<SearchResponse> searchProduct({
    required String url,
    required String token,
    required String lang,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiConsumer.postData(
        url: url, data: data, lang: lang, token: token);
    _checkError(response);
    return SearchResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<Map<String, dynamic>> toggleFavorite(
      {required String url,
      required String token,
      required String lang,
      required Map<String, dynamic> data}) async {
    final response = await apiConsumer.postData(
        url: url, data: data, token: token, lang: lang);
    _checkError(response);
    return {
      'message': response.data['message'],
      'id': response.data['data']['id']
    };
  }

  @override
  Future<AddressResponse> updateAddress({
    required String url,
    required Map<String, dynamic> data,
    required String lang,
    required String token,
  }) async {
    final response = await apiConsumer.putData(
        url: url, data: data, lang: lang, token: token);
    _checkError(response);
    return AddressResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<CartUpdateResponse> updateCart({
    required String url,
    required Map<String, dynamic> data,
    required String lang,
    required String token,
  }) async {
    final response = await apiConsumer.putData(
        url: url, data: data, token: token, lang: lang);
    _checkError(response);
    return CartUpdateResponseModel.fromJson(jsonMap: response.data);
  }

  @override
  Future<ProfileResponse> updateUserProfile(
      {required String url,
      required Map<String, dynamic> data,
      required String lang,
      required String token}) async {
    final response = await apiConsumer.putData(
        url: url, data: data, token: token, lang: lang);
    _checkError(response);
    return ProfileResponseModel.fromJson(jsonMap: response.data);
  }
}
