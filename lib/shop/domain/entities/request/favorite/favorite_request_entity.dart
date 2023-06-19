import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class FavoriteRequestEntity implements BaseRequestEntity {
  const FavoriteRequestEntity({
    required this.productId,
  });

  final int productId;

  @override
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
    };
  }
}
