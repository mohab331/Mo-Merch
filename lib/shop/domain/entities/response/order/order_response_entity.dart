import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class OrderResponseEntity {
  final String paymentMethod;
  final double cost;
  final double vat;
  final double discount;
  final int points;
  final double total;
  final List<ProductResponseEntity> products;
  final int id;

  OrderResponseEntity({
    required this.id,
    required this.points,
    required this.total,
    required this.discount,
    required this.paymentMethod,
    required this.vat,
    required this.products,
    required this.cost,
  });
}
