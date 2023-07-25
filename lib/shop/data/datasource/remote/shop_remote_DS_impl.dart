import 'package:dio/dio.dart';
import 'package:shop_app_clean_architecture/core/error/exception.dart';
import 'package:shop_app_clean_architecture/core/network/error_model.dart';
import 'package:shop_app_clean_architecture/shop/data/datasource/remote/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class ShopRemoteDSImpl implements BaseShopRemoteDS {
  const ShopRemoteDSImpl({
    required this.apiConsumer,
  });
  final ApiConsumer apiConsumer;

  void _checkResponseError(Response response) {
    if (response.data['status'] == false || response.statusCode != 200) {
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          jsonMap: response.data,
        ),
      );
    }
  }

  /// Makes a POST request to the server and handles the response.
  Future<BaseResponseModel<T>> _postRequest<T extends JsonConverter>({
    required String url,
    required Map<String, dynamic> data,
    required T modelInstance,
    bool requiresToken = true,
  }) async {
    final response = await apiConsumer.postData(
      url: url,
      data: data,
      requiresToken: requiresToken,
    );
    _checkResponseError(response);
    return BaseResponseModel<T>.fromJson(
      jsonMap: response.data,
      modelInstance: modelInstance,
    );
  }

  /// Makes a GET request to the server and handles the response.
  Future<BaseResponseModel<T>> _getRequest<T extends JsonConverter>({
    required String url,
    required T modelInstance,
    bool requiresToken = true,
  }) async {
    final response = await apiConsumer.getData(
      url: url,
      requiresToken: requiresToken,
    );
    _checkResponseError(response);
    return BaseResponseModel<T>.fromJson(
      jsonMap: response.data,
      modelInstance: modelInstance,
    );
  }

  /// Makes a DELETE request to the server and handles the response.
  Future<BaseResponseModel<T>> _deleteRequest<T extends JsonConverter>({
    required String url,
    required T modelInstance,
    bool requiresToken = true,
  }) async {
    final response = await apiConsumer.deleteData(
      url: url,
      requiresToken: requiresToken,
    );
    _checkResponseError(response);
    return BaseResponseModel<T>.fromJson(
      jsonMap: response.data,
      modelInstance: modelInstance,
    );
  }

  /// Makes a PUT request to the server and handles the response.
  Future<BaseResponseModel<T>> _putRequest<T extends JsonConverter>({
    required String url,
    required Map<String, dynamic> data,
    required T modelInstance,
    bool requiresToken = true,
  }) async {
    final response = await apiConsumer.putData(
      url: url,
      data: data,
      requiresToken: requiresToken,
    );
    _checkResponseError(response);
    return BaseResponseModel<T>.fromJson(
      jsonMap: response.data,
      modelInstance: modelInstance,
    );
  }

  @override

  /// Adds a new address by making a POST request to the server.
  Future<BaseResponseModel<AddressResponseModel>> addNewAddress({
    required AddAddressRequestModel addAddressRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.address,
      data: addAddressRequestModel.toJson(),
      modelInstance: const AddressResponseModel(),
      requiresToken: true,
    );
  }

  @override

  /// Adds or deletes an item from favorites by making a POST request to the server.
  Future<BaseResponseModel<ToggleFavoriteResponseModel>>
      addOrDeleteFromFavorites({
    required FavoriteRequestModel favoriteRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.favorites,
      data: favoriteRequestModel.toJson(),
      modelInstance: const ToggleFavoriteResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<EmptyResponseModel>> addToCart({
    required AddToCartRequestModel addToCartRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.carts,
      data: addToCartRequestModel.toJson(),
      modelInstance: const EmptyResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<ChangePasswordResponseModel>> changeUserPassword({
    required ChangePasswordRequestModel changePasswordRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.changePassword,
      data: changePasswordRequestModel.toJson(),
      modelInstance: const ChangePasswordResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<OrderResponseModel>> createOrder({
    required AddOrderRequestModel addOrderRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.orders,
      data: addOrderRequestModel.toJson(),
      modelInstance: const OrderResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<CartResponseModel>> getCartData() async {
    return _getRequest(
      url: Endpoints.carts,
      modelInstance: const CartResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<CategoryResponseModel>> getCategories({
    required int page,
  }) async {
    final response = await apiConsumer.getData(
      url: Endpoints.categories,
      requiresToken: false,
      queryMap: {
        'page': page,
      },
    );
    _checkResponseError(response);
    return BaseListResponseModel<CategoryResponseModel>.fromJson(
      jsonData: response.data,
      instance: const CategoryResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<ProductResponseModel>> getCategoryProductsById({
    required CategoryProductsRequestModel categoryProductsRequestModel,
  }) async {
    final response = await apiConsumer.getData(
      url: Endpoints.concatenateEndPoint(
        endPoint: Endpoints.categories,
        id: categoryProductsRequestModel.categoryId,
      ),
      requiresToken: false,
      queryMap: categoryProductsRequestModel.toJson(),
    );
    _checkResponseError(response);
    return BaseListResponseModel<ProductResponseModel>.fromJson(
      jsonData: response.data,
      instance: const ProductResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<FavoriteResponseModel>> getFavoriteData({required int page,}) async {
    final response = await apiConsumer.getData(
      url: Endpoints.favorites,
      queryMap: {'page':page,}
    );
    _checkResponseError(response);
    return BaseListResponseModel<FavoriteResponseModel>.fromJson(
      jsonData: response.data,
      instance: const FavoriteResponseModel(),
    );
  }

  @override

  /// Retrieves the home data by making a GET request to the server.
  Future<BaseResponseModel<HomeResponseModel>> getHomeData() async {
    return _getRequest(
      url: Endpoints.home,
      modelInstance: const HomeResponseModel(),
      requiresToken: false,
    );
  }

  @override

  /// Retrieves the details of an order with the provided order details request model by making a GET request to the server.
  Future<BaseResponseModel<OrderDetailsResponseModel>> getOrderDetails({
    required OrderDetailsRequestModel orderDetailsRequestModel,
  }) async {
    return _getRequest(
      url: Endpoints.concatenateEndPoint(
        endPoint: Endpoints.orders,
        id: orderDetailsRequestModel.orderId,
      ),
      modelInstance: const OrderDetailsResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<OrderResponseModel>> getOrders({required int page,}) async {
    final response = await apiConsumer.getData(
      url: Endpoints.orders,
      queryMap: {'page':page,}
    );
    _checkResponseError(response);
    return BaseListResponseModel<OrderResponseModel>.fromJson(
      jsonData: response.data,
      instance: const OrderResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<AddressResponseModel>> getUserAddress({
    required int page,
  }) async {
    final response =
        await apiConsumer.getData(url: Endpoints.address, queryMap: {
      'page': page,
    });
    _checkResponseError(response);
    return BaseListResponseModel<AddressResponseModel>.fromJson(
      jsonData: response.data,
      instance: const AddressResponseModel(),
    );
  }

  @override

  /// Retrieves the user's profile data by making a GET request to the server.
  Future<BaseResponseModel<UserResponseModel>> getUserProfile() async {
    return _getRequest(
      url: Endpoints.profile,
      modelInstance: const UserResponseModel(),
    );
  }

  @override

  /// Logs in a user with the provided login request model by making a POST request to the server.
  Future<BaseResponseModel<UserResponseModel>> loginUser({
    required LoginRequestModel loginRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.login,
      data: loginRequestModel.toJson(),
      requiresToken: false,
      modelInstance: const UserResponseModel(),
    );
  }

  @override

  /// Logs out the current user by making a POST request to the server.
  Future<BaseResponseModel<LogoutResponseModel>> logout() async {
    return _postRequest(
      url: Endpoints.logout,
      data: {},
      modelInstance: const LogoutResponseModel(),
    );
  }

  @override

  /// Registers a new user with the provided register request model by making a POST request to the server.
  Future<BaseResponseModel<UserResponseModel>> registerUser({
    required RegisterRequestModel registerRequestModel,
  }) async {
    return _postRequest(
      url: Endpoints.register,
      data: registerRequestModel.toJson(),
      requiresToken: false,
      modelInstance: const UserResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<EmptyResponseModel>> removeFromCart({
    required DeleteCartItemRequestModel deleteCartItemRequestModel,
  }) async {
    return _deleteRequest(
      url: Endpoints.concatenateEndPoint(
        endPoint: Endpoints.carts,
        id: deleteCartItemRequestModel.cartItemId,
      ),
      modelInstance: const EmptyResponseModel(),
    );
  }

  @override
  Future<BaseListResponseModel<ProductResponseModel>> searchProduct({
    required SearchRequestModel searchRequestModel,
  }) async {
    final response = await apiConsumer.postData(
      url: Endpoints.search,
      data: searchRequestModel.toJson(),
    );
    _checkResponseError(response);
    return BaseListResponseModel<ProductResponseModel>.fromJson(
      jsonData: response.data,
      instance: const ProductResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<CartUpdateResponseModel>> updateCart({
    required UpdateCartRequestModel updateCartRequestModel,
  }) async {
    return _putRequest(
      url: Endpoints.concatenateEndPoint(
        endPoint: Endpoints.carts,
        id: updateCartRequestModel.id,
      ),
      data: updateCartRequestModel.toJson(),
      modelInstance: const CartUpdateResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<UserResponseModel>> updateUserProfile({
    required UpdateProfileRequestModel updateProfileRequestModel,
  }) async {
    return _putRequest(
      url: Endpoints.updateProfile,
      data: updateProfileRequestModel.toJson(),
      modelInstance: const UserResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<ProductResponseModel>> getProductDetails({
    required int productId,
  }) async {
    return _getRequest(
      url: Endpoints.concatenateEndPoint(
        endPoint: Endpoints.productDetails,
        id: productId,
      ),
      modelInstance: const ProductResponseModel(),
    );
  }

  @override
  Future<BaseResponseModel<EmptyResponseModel>> editOrder({required int orderId}) {
    return _getRequest(url: Endpoints.cancelOrder(orderId: orderId), modelInstance: EmptyResponseModel(),);
  }
}
