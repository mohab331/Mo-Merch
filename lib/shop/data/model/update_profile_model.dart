import 'package:shop_app_clean_architecture/shop/data/model/user_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/profile.dart';

class ProfileResponseModel extends ProfileResponse {
  ProfileResponseModel._(
      {required super.status, required super.message, required super.user});
  factory ProfileResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      ProfileResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        user: UserModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}
