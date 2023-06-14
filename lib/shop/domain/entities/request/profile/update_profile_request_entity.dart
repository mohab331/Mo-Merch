import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class UpdateProfileRequestEntity implements BaseRequestEntity {
  const UpdateProfileRequestEntity({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
