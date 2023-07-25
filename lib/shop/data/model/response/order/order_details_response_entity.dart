import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/address/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/order/index.dart';

class OrderDetailsResponseModel
    implements JsonConverter<OrderDetailsResponseModel> {
  const OrderDetailsResponseModel({
     this.orderData,
      this.addressData,
      this.total,
      this.vat,
      this.paymentMethod,
      this.discount,
      this.cost,
      this.promoCode,
      this.orderProducts,
  });

  final double? total;
  final double? vat;
  final String? paymentMethod;
  final double? discount;
  final double? cost;
  final OrderResponseModel? orderData;
  final String? promoCode;
  final AddressResponseModel? addressData;
  final List<ProductOrderResponseModel>? orderProducts;

  @override
  OrderDetailsResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return OrderDetailsResponseModel(
        orderData: const OrderResponseModel().fromJson(jsonMap),
        addressData: const AddressResponseModel().fromJson(jsonMap?['address']),
        promoCode: jsonMap?['promo_code'],
        orderProducts: (jsonMap?['products'] as List?)?.map((e) {
          return const ProductOrderResponseModel().fromJson(e);
        }).toList(),
    discount: (jsonMap?['discount'] as num).toDouble(),

    cost: (jsonMap?['cost'] as num).toDouble(),
    paymentMethod: jsonMap?['payment_method'],
      total: (jsonMap?['total'] as num).toDouble(),
      vat: (jsonMap?['vat'] as num).toDouble(),
    );
  }
}
