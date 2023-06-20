import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class UserDataResponseModel implements JsonConverter<UserDataResponseModel> {
  const UserDataResponseModel({
    this.token,
    this.userName,
  });
  final String? userName;
  final String? token;

  factory UserDataResponseModel.fromJson({required Map<String,dynamic>? jsonMap,}){
    return UserDataResponseModel(
      token: jsonMap?['token'],
      userName: jsonMap?['name'],
    );
  }

  @override
  UserDataResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return UserDataResponseModel(
      token: jsonMap?['token'],
      userName: jsonMap?['name'],
    );
  }
}
