import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class UpdateProfileRequestModel implements BaseRequestModel {
  const UpdateProfileRequestModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
