import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

abstract class CartState {
  CartState({this.message,});
  final String? message;
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}



class AddToCartSuccessState extends CartState {
  AddToCartSuccessState({
     super.message,
  });
}

class GetCartSuccessState extends CartState {
  GetCartSuccessState({
    super.message,
    this.cart,
  });
  final List<CartItem>? cart;
}

class UpdateCartSuccessState extends CartState {
  UpdateCartSuccessState({
    required this.cartUpdateResponse,
    super.message,
  });
  final CartUpdateResponseEntity cartUpdateResponse;
}

class DeleteCartSuccessState extends CartState {
  DeleteCartSuccessState({
    super.message,
  });
}

class CartErrorState extends CartState {
  CartErrorState({
    super.message,
  });
}
