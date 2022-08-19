import 'package:shop_app_clean_architecture/shop/data/model/user_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/login.dart';

class LoginResponseModel extends LoginResponse {
  LoginResponseModel._(
      {required super.message, required super.status, required super.user});
  factory LoginResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      LoginResponseModel._(
        message: jsonMap['message'],
        status: jsonMap['status'],
        user: UserModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}
