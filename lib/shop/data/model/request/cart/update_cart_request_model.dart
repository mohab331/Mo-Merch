import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class UpdateCartRequestModel implements BaseRequestModel {
  const UpdateCartRequestModel({
    required this.id,
    required this.quantity,
  });

  final int id;
  final int quantity;

  @override
  Map<String, dynamic> toJson() => {
        'quantity': quantity,
      };
}
