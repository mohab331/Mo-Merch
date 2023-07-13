import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/base_model/base_list_response_model.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/cart/cart_item_model.dart';

class CartResponseModel
    implements JsonConverter<CartResponseModel> {
  const CartResponseModel({
  this.cartItems,
     this.totalCost,

  });

  final int? totalCost;
  final List<CartItemModel>? cartItems;

  @override
  CartResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return CartResponseModel(
      cartItems: (jsonMap?['cart_items'] as List?)?.map((e) {
              return const CartItemModel().fromJson(
                e,
              );
            }).toList(),
      totalCost: (jsonMap?['total'] as num?)?.toInt(),
    );
  }
}
