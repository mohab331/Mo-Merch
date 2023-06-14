import 'package:shop_app_clean_architecture/shop/domain/entities/response/index.dart';

class CartResponseEntity extends BaseListResponseEntity<CartItem> {
  const CartResponseEntity({
    required super.entityList,
    required this.totalCost,
    super.message,
    super.status,
  });

  final double totalCost;
}
