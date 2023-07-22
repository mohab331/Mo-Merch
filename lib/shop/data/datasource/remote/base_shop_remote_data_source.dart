import 'package:shop_app_clean_architecture/shop/data/model/index.dart';

abstract class BaseShopRemoteDS {
  // Home

  /// Retrieves home data.
  Future<BaseResponseModel<HomeResponseModel>> getHomeData();

  // Addresses

  /// Adds a new address.
  ///
  /// Returns a [BaseResponseModel] containing the added [AddressResponseModel] if successful.
  Future<BaseResponseModel<AddressResponseModel>> addNewAddress({
    required AddAddressRequestModel addAddressRequestModel,
  });

  /// Retrieves user addresses.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [AddressResponseModel].
  Future<BaseListResponseModel<AddressResponseModel>> getUserAddress({
    required int page,
  });

  // Cart

  /// Adds a product to the cart.
  ///
  /// Returns a [BaseResponseModel] with [EmptyResponseModel] if successful.
  Future<BaseResponseModel<EmptyResponseModel>> addToCart({
    required AddToCartRequestModel addToCartRequestModel,
  });

  /// Updates the cart.
  ///
  /// Returns a [BaseResponseModel] containing the updated [CartUpdateResponseModel] if successful.
  Future<BaseResponseModel<CartUpdateResponseModel>> updateCart({
    required UpdateCartRequestModel updateCartRequestModel,
  });

  /// Retrieves cart data.
  ///
  /// Returns a [BaseResponseModel] containing the [CartResponseModel] representing the current state of the cart.
  Future<BaseResponseModel<CartResponseModel>> getCartData();

  /// Removes a product from the cart.
  ///
  /// Returns a [BaseResponseModel] with [EmptyResponseModel] if successful.
  Future<BaseResponseModel<EmptyResponseModel>> removeFromCart({
    required DeleteCartItemRequestModel deleteCartItemRequestModel,
  });

  // User Profile

  /// Changes the user's password.
  ///
  /// Returns a [BaseResponseModel] containing the updated [ChangePasswordResponseModel] if successful.
  Future<BaseResponseModel<ChangePasswordResponseModel>> changeUserPassword({
    required ChangePasswordRequestModel changePasswordRequestModel,
  });

  /// Retrieves the user's profile.
  ///
  /// Returns a [BaseResponseModel] containing the [UserResponseModel] representing the user's profile.
  Future<BaseResponseModel<UserResponseModel>> getUserProfile();

  /// Updates the user's profile.
  ///
  /// Returns a [BaseResponseModel] containing the updated [UserResponseModel] if successful.
  Future<BaseResponseModel<UserResponseModel>> updateUserProfile({
    required UpdateProfileRequestModel updateProfileRequestModel,
  });

  // Order

  /// Creates a new order.
  ///
  /// Returns a [BaseResponseModel] containing the created [OrderResponseModel] if successful.
  Future<BaseResponseModel<OrderResponseModel>> createOrder({
    required AddOrderRequestModel addOrderRequestModel,
  });

  /// Retrieves order details.
  ///
  /// Returns a [BaseResponseModel] containing the [OrderDetailsResponseModel] for the specified order.
  Future<BaseResponseModel<OrderDetailsResponseModel>> getOrderDetails({
    required OrderDetailsRequestModel orderDetailsRequestModel,
  });

  /// Retrieves user orders.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [OrderResponseModel].
  Future<BaseListResponseModel<OrderResponseModel>> getOrders();

  // Category

  /// Retrieves categories.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [CategoryResponseModel].
  Future<BaseListResponseModel<CategoryResponseModel>> getCategories({required int page,});

  /// Retrieves products by category ID.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [ProductResponseModel] for the specified category.
  Future<BaseListResponseModel<ProductResponseModel>> getCategoryProductsById({
    required CategoryProductsRequestModel categoryProductsRequestModel,
  });

  // Favorite

  /// Retrieves favorite products.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [FavoriteResponseModel] representing the user's favorites.
  Future<BaseListResponseModel<FavoriteResponseModel>> getFavoriteData({required int page,});

  /// Adds or deletes a product from favorites.
  ///
  /// Returns a [BaseResponseModel] containing the [ToggleFavoriteResponseModel] if successful.
  Future<BaseResponseModel<ToggleFavoriteResponseModel>>
      addOrDeleteFromFavorites({
    required FavoriteRequestModel favoriteRequestModel,
  });

  // Search

  /// Searches for a product.
  ///
  /// Returns a [BaseListResponseModel] containing a list of [ProductResponseModel] matching the search query.
  Future<BaseListResponseModel<ProductResponseModel>> searchProduct({
    required SearchRequestModel searchRequestModel,
  });

  // product

  /// get product details.
  ///
  /// Returns a [BaseResponseModel] containing   [ProductResponseModel] matching the product id.
  Future<BaseResponseModel<ProductResponseModel>> getProductDetails({
    required int productId,
  });

  // Authentication

  /// Registers a new user.
  ///
  /// Returns a [BaseResponseModel] containing the registered [UserResponseModel] if successful.
  Future<BaseResponseModel<UserResponseModel>> registerUser({
    required RegisterRequestModel registerRequestModel,
  });

  /// Logs in a user.
  ///
  /// Returns a [BaseResponseModel] containing the logged-in [UserResponseModel] if successful.
  Future<BaseResponseModel<UserResponseModel>> loginUser({
    required LoginRequestModel loginRequestModel,
  });

  /// Logs out the user.
  ///
  /// Returns a [BaseResponseModel] containing the [LogoutResponseModel] if successful.
  Future<BaseResponseModel<LogoutResponseModel>> logout();
}
