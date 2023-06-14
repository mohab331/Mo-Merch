import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class OrderDetailsRequestEntity implements BaseRequestEntity {
  const OrderDetailsRequestEntity({
    required this.orderId,
  });

  final int orderId;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
