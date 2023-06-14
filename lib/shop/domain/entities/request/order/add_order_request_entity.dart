import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class AddOrderRequestEntity implements BaseRequestEntity {
  final int addressId;
  final int paymentMethod;
  final bool usePoints;

  AddOrderRequestEntity({
    required this.addressId,
    required this.paymentMethod,
    this.usePoints = false,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'payment_method': paymentMethod,
      'use_points': usePoints,
    };
  }
}
