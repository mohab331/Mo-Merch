import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class DeleteCartItemRequestEntity implements BaseRequestEntity {
  const DeleteCartItemRequestEntity({
    required this.cartItemId,
  });

  final int cartItemId;

  @override
  Map<String, dynamic> toJson() => {
        'id': cartItemId,
      };
}
