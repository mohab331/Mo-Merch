import 'package:shop_app_clean_architecture/shop/domain/entities/user.dart';

class RegisterResponse{
  bool status;
  String message;
  User user;
  RegisterResponse({required this.status , required this.message , required this.user});
}