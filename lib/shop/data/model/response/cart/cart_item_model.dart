import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/product/index.dart';

class CartItemModel implements JsonConverter<CartItemModel> {
  const CartItemModel({
     this.product,
     this.id,
     this.quantity,
  });
  final int? id;
  final int? quantity;
  final ProductResponseModel? product;

  @override
  CartItemModel fromJson(Map<String, dynamic>? jsonMap) {
    return CartItemModel(
      product: ProductResponseModel().fromJson(
        jsonMap?['product'],
      ),
      id: jsonMap?['id'],
      quantity: jsonMap?['quantity'],
    );
  }
}
