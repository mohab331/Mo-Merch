import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class LoginRequestModel implements BaseRequestModel {
  LoginRequestModel({
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
