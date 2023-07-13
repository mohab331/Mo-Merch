import 'package:shop_app_clean_architecture/shop/domain/entities/response/index.dart';

class CartResponseEntity {
  const CartResponseEntity({
    required this.cartItems,
    required this.totalCost,
  });

  final int totalCost;
  final List<CartItem> cartItems;
}
