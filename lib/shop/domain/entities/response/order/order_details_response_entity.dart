import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class OrderDetailsResponseEntity {
  const OrderDetailsResponseEntity({
    required this.status,
    required this.orderData,
    required this.addressData,
    required this.date,
    required this.promoCode,
    required this.orderProducts,
  });

  final OrderResponseEntity orderData;
  final String promoCode;
  final String date;
  final String status;
  final AddressResponseEntity addressData;
  final List<ProductOrderResponseEntity> orderProducts;
}
