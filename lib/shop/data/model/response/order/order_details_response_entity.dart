import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/address/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/order/index.dart';

class OrderDetailsResponseModel
    implements JsonConverter<OrderDetailsResponseModel> {
  const OrderDetailsResponseModel({
    this.status,
    this.orderData,
    this.addressData,
    this.date,
    this.promoCode,
    this.orderProducts,
  });

  final OrderResponseModel? orderData;
  final String? promoCode;
  final String? date;
  final String? status;
  final AddressResponseModel? addressData;
  final List<ProductOrderResponseModel>? orderProducts;

  @override
  OrderDetailsResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return OrderDetailsResponseModel(
        status: jsonMap?['status'],
        orderData: OrderResponseModel().fromJson(jsonMap),
        addressData: const AddressResponseModel().fromJson(jsonMap?['address']),
        date: jsonMap?['date'],
        promoCode: jsonMap?['promo_code'],
        orderProducts: (jsonMap?['products'] as List?)?.map((e) {
          return const ProductOrderResponseModel().fromJson(e);
        }).toList());
  }
}
