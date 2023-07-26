import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class OrderResponseModel implements JsonConverter<OrderResponseModel> {
  const OrderResponseModel({
    this.id,
    this.orderStatus,
    this.total,
    this.orderDate,
  });

  final String? orderDate;
  final double? total;
  final int? id;
  final String? orderStatus;

  @override
  OrderResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return OrderResponseModel(
      id: jsonMap?['id'],
      total: (jsonMap?['total'] as num?)?.toDouble(),
      orderStatus: jsonMap?['status'],
      orderDate: jsonMap?['date'],
    );
  }
}
