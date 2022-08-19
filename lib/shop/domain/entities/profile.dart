import 'package:shop_app_clean_architecture/shop/domain/entities/user.dart';

class ProfileResponse{
  late bool status;
  String? message;
  User user;
  ProfileResponse({required this.status , required this.message ,required this.user});
}