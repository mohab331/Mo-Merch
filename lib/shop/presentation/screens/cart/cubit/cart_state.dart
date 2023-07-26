import 'package:flutter/material.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class CartState {
  CartState({
    this.message,
    this.toastColor,
  });

  final String? message;
  final Color? toastColor;
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class AddToCartSuccessState extends CartState {
  AddToCartSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class GetCartSuccessState extends CartState {
  GetCartSuccessState({
    super.message,
    super.toastColor = Colors.green,
    this.cart,
  });

  final List<CartItem>? cart;
}

class UpdateCartSuccessState extends CartState {
  UpdateCartSuccessState({
    required this.cartUpdateResponse,
    super.message,
    super.toastColor = Colors.green,
  });

  final CartUpdateResponseEntity cartUpdateResponse;
}

class DeleteCartSuccessState extends CartState {
  DeleteCartSuccessState({
    super.message,
    super.toastColor = Colors.green,
  });
}

class DeleteCartLoadingState extends CartState {
  DeleteCartLoadingState();
}

class InstantToggleCartState extends CartState {}

class CartErrorState extends CartState {
  CartErrorState({
    super.message,
    super.toastColor = Colors.red,
  });
}
