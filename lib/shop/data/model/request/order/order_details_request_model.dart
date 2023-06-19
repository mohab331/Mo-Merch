import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class OrderDetailsRequestModel implements BaseRequestModel {
  const OrderDetailsRequestModel({
    required this.orderId,
  });

  final int orderId;

  @override
  Map<String, dynamic> toJson() {
    return {'id':orderId,};
  }
}
