import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({
    required this.addToCartUseCase,
    required this.deleteCartUseCase,
    required this.getCartUseCase,
    required this.updateCartUsecase,
  }) : super(
          CartInitialState(),
        );

  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;
  final DeleteCartUseCase deleteCartUseCase;
  final UpdateCartUsecase updateCartUsecase;

  Map<int, ProductResponseEntity> productsInCart = {};
  Map<int,CartItem> _cartItems = {};

  double cartTotal = 0.0;

  void addToCart({
    required ProductResponseEntity product,
  }) async {
    emit(CartLoadingState());
    final response = await addToCartUseCase.call(
      AddToCartRequestEntity(
        productId: product.id,
      ),
    );
    response.fold((failure) {
      emit(
        CartErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (addToCartResponse) {
      _handleAddingProductsToCart(product);
      emit(
        AddToCartSuccessState(
          message: addToCartResponse.message,
        ),
      );
    });
  }

  bool isProductInCart({required int productId}) {
    return productsInCart.containsKey(productId,);
  }

  void _handleAddingProductsToCart(ProductResponseEntity product) {
    if (!isProductInCart(productId: product.id,)) {
      productsInCart.addAll({
        product.id: product,
      });
    }
  }

  void getCart() async {
    emit(CartLoadingState());
    final response = await getCartUseCase.call(
      const NoParameters(),
    );
    response.fold(
      (failure) {
        emit(
          CartErrorState(
            message: failure.failureMessage,
          ),
        );
      },
      (getCartResponse) {
        getCartResponse.entity.cartItems.forEach((element) {
          _handleAddingProductsToCart(element.product);
          _cartItems.addAll({element.product.id:element,});
        });
        cartTotal = getCartResponse.entity.totalCost.toDouble() ;
        emit(
          GetCartSuccessState(
            message: getCartResponse.message,
            cart: getCartResponse.entity.cartItems,
          ),
        );
      },
    );
  }

  void updateCart({
    required int cartID,
    required int quantity,
  }) async {
    emit(CartLoadingState());
    final response = await updateCartUsecase.call(
      UpdateCartRequestEntity(
        id: cartID,
        quantity: quantity,
      ),
    );
    response.fold((failure) {
      emit(
        CartErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (updateCartResponse) {
      cartTotal = updateCartResponse.entity.total;
      emit(
        UpdateCartSuccessState(
          cartUpdateResponse: updateCartResponse.entity,
        ),
      );
    });
  }

  void deleteFromCart({
    required CartItem cartItem,
  }) async {
    emit(CartLoadingState());
    final response = await deleteCartUseCase.call(
      DeleteCartItemRequestEntity(
        cartItemId: cartItem.id,
      ),
    );
    response.fold((failure) {
      emit(
        CartErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (deleteCartResponse) {
      cartTotal -= (cartItem.product.price) * cartItem.quantity;
      productsInCart.remove(cartItem.product.id);
      _cartItems.remove(cartItem.product.id);
      emit(
        DeleteCartSuccessState(
          message: deleteCartResponse.message,
        ),
      );
    });
  }

  void toggleCart(ProductResponseEntity product){
    if(isProductInCart(productId: product.id,)){
      deleteFromCart(cartItem: _cartItems[product.id]!);
    }else{
      addToCart(product: product);
    }
  }
}
