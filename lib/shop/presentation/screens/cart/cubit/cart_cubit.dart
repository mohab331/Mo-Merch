import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

/// The `CartCubit` class is responsible for managing the state of the cart in the application.
/// It extends the `Cubit` class from the BLoC package, allowing it to emit different states based on the cart operations.
class CartCubit extends Cubit<CartState> {
  /// Creates an instance of the `CartCubit`.
  /// Requires the necessary use cases for cart operations.
  CartCubit({
    required this.addToCartUseCase,
    required this.deleteCartUseCase,
    required this.getCartUseCase,
    required this.updateCartUseCase,
  }) : super(CartInitialState());

  /// The use cases required for cart operations.
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;
  final UpdateCartUsecase updateCartUseCase;

  /// The map that stores the products currently in the cart, with their IDs as keys.
  Map<int, ProductResponseEntity> productsInCart = {};

  /// The map that stores the cart items, with their IDs as keys.
  Map<int, CartItem> cartItems = {};

  /// The total cost of the items in the cart.
  int cartTotal = 0;

  /// Adds a product to the cart.
  /// Emits `CartLoadingState` initially, then calls the `addToCartUseCase` to add the product to the cart.
  /// If successful, updates the cart locally and emits `AddToCartSuccessState`.
  /// If there is an error, emits `CartErrorState` with the error message.
  void addToCart({
    required ProductResponseEntity product,
  }) async {
    emit(CartLoadingState());

    final response = await addToCartUseCase.call(
      AddToCartRequestEntity(productId: product.id),
    );

    response.fold(
      (failure) {
        emit(CartErrorState(message: failure.failureMessage));
      },
      (addToCartResponse) {
        _handleAddingProductsToCart(product);
        emit(AddToCartSuccessState(message: addToCartResponse.message));
      },
    );
  }

  /// Retrieves the cart items and total cost from the server.
  /// Emits `CartLoadingState` initially, then calls the `getCartUseCase` to fetch the cart data.
  /// If successful, updates the cart locally and emits `GetCartSuccessState`.
  /// If there is an error, emits `CartErrorState` with the error message.
  void getCart() async {
    emit(CartLoadingState());

    final response = await getCartUseCase.call(const NoParameters());

    response.fold(
      (failure) {
        emit(CartErrorState(message: failure.failureMessage));
      },
      (getCartResponse) {
        if (getCartResponse.entity.cartItems.isNotEmpty) {
          getCartResponse.entity.cartItems.forEach((element) {
            _handleAddingProductsToCart(element.product);
            cartItems[element.id] = element;
          });
        } else {
          cartItems.clear();
          productsInCart.clear();
        }
        cartTotal = getCartResponse.entity.totalCost;
        // emit(
        //   GetCartSuccessState(
        //     message: getCartResponse.message,
        //     cart: getCartResponse.entity.cartItems,
        //   ),
        // );
        emit(CartErrorState(message: 'failure.failureMessage'));
      },
    );
  }

  /// Updates the quantity of a cart item.
  /// Emits `InstantToggleCartState` to trigger an instant UI update before the API call.
  /// Calls the `updateCartUseCase` to update the cart item's quantity.
  /// If successful, updates the cart locally and emits `UpdateCartSuccessState`.
  /// If there is an error, reverts the changes and emits `CartErrorState` with the error message.
  Future<void> updateCart({
    required CartItem cartItem,
    required int quantity,
  }) async {
    if (getCartItem(cartItem.id).quantity == 1 && quantity == -1) {
      deleteFromCart(cartItem: cartItem);
      return;
    }
    _handleInstantCartUpdate(cartItem.id, quantity);
    emit(InstantToggleCartState());

    final response = await updateCartUseCase.call(
      UpdateCartRequestEntity(
        id: cartItem.id,
        quantity: getCartItem(cartItem.id).quantity,
      ),
    );

    response.fold(
      (failure) {
        _handleInstantCartErrorUpdate(cartItem.id, quantity);
        emit(CartErrorState(message: failure.failureMessage));
      },
      (updateCartResponse) {
        emit(
          UpdateCartSuccessState(
            cartUpdateResponse: updateCartResponse.entity,
            message: updateCartResponse.message,
          ),
        );
      },
    );
  }

  /// Deletes a cart item.
  /// Emits `InstantToggleCartState` to trigger an instant UI update before the API call.
  /// Calls the `deleteCartUseCase` to remove the cart item from the server.
  /// If successful, removes the cart item locally and emits `DeleteCartSuccessState`.
  /// If there is an error, reverts the changes and emits `CartErrorState` with the error message.
  void deleteFromCart({
    required CartItem cartItem,
  }) async {
    _handleInstantCartDelete(cartItem);
    emit(InstantToggleCartState());

    final response = await deleteCartUseCase.call(
      DeleteCartItemRequestEntity(cartItemId: cartItem.id),
    );
    response.fold(
      (failure) {
        _handleInstantCartDeleteErrorState(cartItem);
        emit(CartErrorState(message: failure.failureMessage));
      },
      (deleteCartResponse) {
        emit(DeleteCartSuccessState(message: deleteCartResponse.message));
      },
    );
  }

  /// Checks if a product is already in the cart.
  bool isProductInCart({required int productId}) {
    return productsInCart.containsKey(productId);
  }

  /// Handles the addition of products to the cart locally.
  /// If the product is not already in the cart, adds it to the `productsInCart` map.
  void _handleAddingProductsToCart(ProductResponseEntity product) {
    if (!isProductInCart(productId: product.id)) {
      productsInCart[product.id] = product;
    }
  }

  /// Checks if a cart item with the given `cartId` exists in the cart.
  bool _isCartItemInCart(int cartId) {
    return cartItems.containsKey(cartId);
  }

  /// Handles the instant update of the cart item's quantity before the API call.
  void _handleInstantCartUpdate(int cartID, int quantity) {
    if (_isCartItemInCart(cartID)) {
      cartItems[cartID]?.quantity += quantity;
      cartTotal += ((cartItems[cartID]?.product.price ?? 0) * quantity);
    }
  }

  /// Handles the instant update of the cart item's quantity if there is an error during the API call.
  void _handleInstantCartErrorUpdate(int cartID, int quantity) {
    _handleInstantCartUpdate(
      cartID,
      (quantity * -1),
    );
  }

  /// Handles the instant removal of a cart item.
  /// Updates the `cartTotal`, `productsInCart`, and `cartItems` locally.
  void _handleInstantCartDelete(CartItem cartItem) {
    cartTotal -= cartItem.product.price * cartItem.quantity;
    productsInCart.remove(cartItem.product.id);
    cartItems.remove(cartItem.id);
  }

  /// Handles the instant restoration of a cart item if there is an error during the API call.
  /// Restores the `cartTotal`, `productsInCart`, and `cartItems` to their previous state.
  void _handleInstantCartDeleteErrorState(CartItem cartItem) {
    cartTotal += cartItem.product.price * cartItem.quantity;
    productsInCart[cartItem.product.id] = cartItem.product;
    cartItems[cartItem.id] = cartItem;
  }

  /// Retrieves the cart item with the given `cartId` from the `cartItems` map.
  /// If the cart item exists, returns it; otherwise, returns a default `CartItem`.
  CartItem getCartItem(int cartId) {
    if (_isCartItemInCart(cartId)) {
      return cartItems[cartId]!;
    }

    return CartItem(
      id: -1,
      product: ProductResponseEntity(
        id: -1,
        image: '',
        discount: 0,
        oldPrice: 0,
        images: [],
        description: '',
        price: 0,
        name: '',
        inCart: false,
        inFavorites: false,
      ),
      quantity: 0,
    );
  }

  /// Toggles the cart by adding or removing the given `product` based on its presence in the cart.
  void toggleCart(ProductResponseEntity product) {
    if (isProductInCart(productId: product.id)) {
      deleteFromCart(cartItem: cartItems[product.id]!);
    } else {
      addToCart(product: product);
    }
  }

  void clearCartItems() {
    cartItems.clear();
    productsInCart.clear();
  }
}
