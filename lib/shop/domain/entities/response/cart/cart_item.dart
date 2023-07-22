import 'package:shop_app_clean_architecture/shop/domain/entities/response/index.dart';

class CartItem {

  CartItem({
    required this.product,
    required this.id,
    required this.quantity,
  });

  final int id;
  int quantity;
  final ProductResponseEntity product;
}
