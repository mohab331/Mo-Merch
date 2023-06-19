import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class ChangePasswordResponseModel implements JsonConverter<ChangePasswordResponseModel>{
  const ChangePasswordResponseModel({
     this.email,
  });

  final String? email;

  @override
  ChangePasswordResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return ChangePasswordResponseModel(email: jsonMap?['email']);
  }
}
