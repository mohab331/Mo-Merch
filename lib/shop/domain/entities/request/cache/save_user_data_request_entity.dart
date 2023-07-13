import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SaveUserDataRequestEntity implements BaseRequestEntity {
  const SaveUserDataRequestEntity({
    required this.id,
    required this.name,
    required this.token,
    required this.email,
    required this.phone,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;

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
