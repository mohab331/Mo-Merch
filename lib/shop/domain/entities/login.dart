import 'package:shop_app_clean_architecture/shop/domain/entities/user.dart';

class LoginResponse{
  bool status;
  String message;
  User user;
  LoginResponse({required this.message , required this.status , required this.user});

}
