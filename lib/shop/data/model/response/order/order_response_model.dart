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
  final int? cost;
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
      total: (jsonMap?['total'] as num?)?.toDouble(),
      discount: (jsonMap?['discount'] as num?)?.toDouble(),
      paymentMethod: jsonMap?['payment_method'],
      vat: (jsonMap?['vat'] as num?)?.toDouble(),
      cost: (jsonMap?['cost'] as num?)?.toInt(),
      products: (jsonMap?['products'] as List?)
          ?.map((e) => ProductResponseModel().fromJson(e))
          .toList(),
    );
  }
}
