import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class UserResponseModel implements JsonConverter<UserResponseModel> {
  const UserResponseModel({
    this.id,
    this.name,
    this.credit,
    this.token,
    this.email,
    this.points,
    this.phone,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final int? points;
  final int? credit;
  final String? token;



  @override
  UserResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return UserResponseModel(
        id: jsonMap?['id'],
        name: jsonMap?['name'],
        credit: (jsonMap?['credit'] as num?)?.toInt(),
        token: jsonMap?['token'],
        email: jsonMap?['email'],
        points: jsonMap?['points'],
        phone: jsonMap?['phone']);
  }
}
