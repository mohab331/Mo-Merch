import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class OrderDetailsResponseEntity {
  const OrderDetailsResponseEntity({
    required this.orderData,
    required this.addressData,
    required this.total,
    required this.vat,
    required this.paymentMethod,
    required this.discount,
    required this.cost,
    required this.promoCode,
    required this.orderProducts,
  });

  final OrderResponseEntity orderData;
  final String promoCode;
  final AddressResponseEntity addressData;
  final double vat;
  final double cost;
  final double total;
  final double discount;
  final String paymentMethod;
  final List<ProductOrderResponseEntity> orderProducts;
}
