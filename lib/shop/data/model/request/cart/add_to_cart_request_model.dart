import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class AddToCartRequestModel implements BaseRequestModel {
  const AddToCartRequestModel({
    required this.productId,
  });

  final int productId;

  @override
  Map<String, dynamic> toJson() => {
        'product_id': productId,
      };
}
