import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class SaveUserDataRequestModel implements BaseRequestModel {
  const SaveUserDataRequestModel({
    required this.name,
    required this.token,
    required this.email,
    required this.id,
    required this.phone,
  });

  final String name;
  final String token;
  final int id;
  final String email;
  final String phone;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'token': token,
      'email': email,
      'phone': phone,
    };
  }
}
