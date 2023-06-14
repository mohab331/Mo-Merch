import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class UpdateCartRequestEntity implements BaseRequestEntity {
  const UpdateCartRequestEntity({
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
