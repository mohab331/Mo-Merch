import 'package:shop_app_clean_architecture/shop/domain/entities/response/index.dart';

class CartItem {
  final int id;
  final int quantity;
  final ProductResponseEntity product;

  CartItem({
    required this.product,
    required this.id,
    required this.quantity,
  });
}
