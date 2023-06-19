import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class LogoutResponseModel implements JsonConverter<LogoutResponseModel> {
  const LogoutResponseModel({
     this.id,
     this.token,
  });

  final int? id;
  final String? token;

  @override
  LogoutResponseModel fromJson(Map<String, dynamic>? jsonMap,) {
    return LogoutResponseModel(
      id: jsonMap?['id'],
      token: jsonMap?['token'],
    );
  }
}
