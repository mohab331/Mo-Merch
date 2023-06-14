import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class LoginRequestEntity implements BaseRequestEntity {
  LoginRequestEntity({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
