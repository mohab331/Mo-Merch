import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/index.dart';

class OrderResponseModel implements JsonConverter<OrderResponseModel> {
  const OrderResponseModel({
     this.id,
     this.points,
     this.total,
     this.discount,
     this.paymentMethod,
     this.vat,
     this.products,
     this.cost,
  });
  final String? paymentMethod;
  final double? cost;
  final double? vat;
  final double? discount;
  final int? points;
  final double? total;
  final List<ProductResponseModel>? products;
  final int? id;

  @override
  OrderResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return OrderResponseModel(
      id: jsonMap?['id'],
      points: jsonMap?['points'],
      total: jsonMap?['total'],
      discount: jsonMap?['discount'],
      paymentMethod: jsonMap?['payment_method'],
      vat: jsonMap?['vat'],
      cost: jsonMap?['cost'],
      products: (jsonMap?['products'] as List?)
              ?.map((e) => ProductResponseModel().fromJson(e))
              .toList(),
    );
  }
}
