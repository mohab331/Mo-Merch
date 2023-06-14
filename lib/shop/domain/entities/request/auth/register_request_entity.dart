import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class RegisterRequestEntity implements BaseRequestEntity {
  const RegisterRequestEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.image,
  });

  final String name;
  final String email;
  final String password;
  final String phone;
  final String image;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image,
    };
  }
}
