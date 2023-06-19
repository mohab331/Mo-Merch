import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class AddOrderRequestModel implements BaseRequestModel {

  const AddOrderRequestModel({
    required this.addressId,
    required this.paymentMethod,
    this.usePoints = false,
  });
  final int addressId;
  final int paymentMethod;
  final bool usePoints;

  @override
  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'payment_method': paymentMethod,
      'use_points': usePoints,
    };
  }
}
