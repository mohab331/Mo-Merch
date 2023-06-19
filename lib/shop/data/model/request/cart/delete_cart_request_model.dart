import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class DeleteCartItemRequestModel implements BaseRequestModel {
  const DeleteCartItemRequestModel({
    required this.cartItemId,
  });

  final int cartItemId;

  @override
  Map<String, dynamic> toJson() => {
        'id': cartItemId,
      };
}
