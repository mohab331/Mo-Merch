import 'package:shop_app_clean_architecture/shop/data/model/user_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/register.dart';

class RegisterResponseModel extends RegisterResponse {
  RegisterResponseModel._(
      {required super.status, required super.message, required super.user});
  factory RegisterResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      RegisterResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        user: UserModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}
