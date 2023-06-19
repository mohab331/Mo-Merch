import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class CartUpdateResponseModel
    implements JsonConverter<CartUpdateResponseModel> {
  const CartUpdateResponseModel({
     this.total,
  });

  final double? total;

  @override
  CartUpdateResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return CartUpdateResponseModel(
      total: jsonMap?['total'],
    );
  }
}
