import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SaveUserDataRequestEntity implements BaseRequestEntity {
  const SaveUserDataRequestEntity({
    required this.token,
    required this.name,
  });

  final String token;
  final String name;

  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
    };
  }
}
