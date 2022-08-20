import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/delete_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/get_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/cart/update_cart_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';

import '../../../../core/utils/app_functions.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());
  static CartCubit get(context) => BlocProvider.of(context);

  CartResponse? cart;

  dynamic cartTotal = 0.0;
  dynamic cartVat = 0.14;
  dynamic cartSubtotal = 0.0;
  Map<int, CartData> cartMap = {};

  void removeFromCart(
    BuildContext context, {
    required CartData cartData,
  }) async {
    _instantDelete(context, cartData: cartData);
    String url = Endpoints.concatenateEndPoint(
        endPoint: Endpoints.carts, id: cartData.id);
    final response = await di.sl<DeleteCartUseCase>().call(
        DeleteUseCaseParameters(
            data: {}, url: url, token: AppCubit.get(context).getUserToken()));
    response.fold((failure) {
      _errorInDelete(context,
          cartData: cartData, errorMessage: failure.failureMessage);
    }, (message) {
      try {
        emit(CartDeleteItemSuccessState(
          message: message,
        ));
      } on StateError catch (_) {
        // TODO
      }
    });
  }

  void _instantDelete(
    BuildContext context, {
    required CartData cartData,
  }) {
    cartMap.remove(cartData.product.id);
    cartTotal -= ((cartData.quantity) * (cartData.product.price));
    cartSubtotal = (cartTotal * cartVat) + cartTotal;
    AppFunctions.updateCartInMap(context, product: cartData.product);
    emit(CartInstantDeleteItemState());
  }

  void _errorInDelete(
    BuildContext context, {
    required CartData cartData,
    required String errorMessage,
  }) {
    cartMap.addAll({cartData.product.id: cartData});
    cartTotal += ((cartData.quantity) * (cartData.product.price));
    cartSubtotal = (cartTotal * cartVat) + cartTotal;
    AppFunctions.updateCartInMap(context, product: cartData.product);
    try {
      emit(
        CartDeleteItemErrorState(
          message: errorMessage,
        ),
      );
    } on StateError catch (_) {
      // TODO
    }
  }

  void _clearCartValues(BuildContext context) {
    cartTotal = 0.0;
    cartSubtotal = 0.0;
    cartMap = {};
    ShopCubit.get(context).productsInCartMap = {};
    cart = null;
  }

  void getCartData(BuildContext context) async {
    emit(CartLoadingState());
    final response = await di.sl<GetCartUseCase>().call(GetUseCaseParameters(
          token: AppCubit.get(context).getUserToken(),
          url: Endpoints.carts,
        ));
    response.fold((failure) {
      emit(
        CartErrorDataState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (cartResponse) {
      _clearCartValues(context);
      cart = cartResponse;
      cartTotal = cart!.cartResponseData.total;
      if (cartResponse.cartResponseData.cartItems.isNotEmpty) {
        for (int i = 0;
            i < cartResponse.cartResponseData.cartItems.length;
            i++) {
          cartMap.addAll({
            cartResponse.cartResponseData.cartItems.elementAt(i).product.id:
                cartResponse.cartResponseData.cartItems.elementAt(i)
          });
          ShopCubit.get(context).productsInCartMap.addAll({
            cartResponse.cartResponseData.cartItems.elementAt(i).product.id:
                cartResponse.cartResponseData.cartItems.elementAt(i).product.name
          });
        }
      }
      cartSubtotal = (cartTotal * cartVat) + cartTotal;
      emit(CartSuccessDataState());
    });
  }

  void updateCart(BuildContext context,
      {required CartData cartData, required int quantity}) async {
    if (cartMap.containsKey(cartData.product.id)) {
      if (cartMap[cartData.product.id]!.quantity + quantity == 0) {
        return;
      }
      _instantUpdate(productId: cartData.product.id, quantity: quantity);
      String url = Endpoints.concatenateEndPoint(
          endPoint: Endpoints.carts, id: cartData.id);
      final response =
          await di.sl<UpdateCartUsecase>().call(UpdateUseCaseParameters(data: {
                'quantity': cartMap[cartData.product.id]!.quantity,
              }, token: AppCubit.get(context).getUserToken(), url: url));
      response.fold((failure) {
        _errorInUpdate(
            productId: cartData.product.id,
            quantity: quantity,
            errorMessage: failure.failureMessage);
      }, (cartUpdateResponse) {
        cartTotal = cartUpdateResponse.cartUpdateResponseData.total;
        try {
          emit(CartUpdateItemSuccessState(message: cartUpdateResponse.message));
        } on StateError catch (_) {
          // TODO
        }
      });
    }
  }

  void _instantUpdate({required int productId, required int quantity}) {
    cartMap[productId] = cartMap.update(productId, (value) {
      value.quantity += quantity;
      return value;
    });
    cartTotal += (quantity * cartMap[productId]!.product.price);
    cartSubtotal = (cartTotal * cartVat) + cartTotal;
    emit(CartUpdateItemInstantState());
  }

  void _errorInUpdate({
    required int productId,
    required int quantity,
    required String errorMessage,
  }) {
    cartMap[productId] = cartMap.update(productId, (value) {
      value.quantity += quantity * -1;
      return value;
    });
    cartTotal += ((quantity * -1) * cartMap[productId]!.product.price);
    cartSubtotal = (cartTotal * cartVat) + cartTotal;
    try {
      emit(
        CartUpdateItemErrorState(
          message: errorMessage,
        ),
      );
    } on StateError catch (_) {
      // TODO
    }
  }
}
