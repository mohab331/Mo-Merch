import 'package:shop_app_clean_architecture/shop/data/index.dart';

class FavoriteRequestModel implements BaseRequestModel {
  const FavoriteRequestModel({
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
