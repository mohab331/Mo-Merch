import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class LoginRequestEntity implements BaseRequestEntity {
  LoginRequestEntity({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  final String email;
  final String password;
  final bool rememberMe;

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
