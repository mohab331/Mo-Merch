import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddToCartRequestEntity implements BaseRequestEntity {
  const AddToCartRequestEntity({
    required this.productId,
  });

  final int productId;

  @override
  Map<String, dynamic> toJson() => {
        'product_id': productId,
      };
}
