import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class SaveUserDataRequestModel implements BaseRequestModel {
  const SaveUserDataRequestModel({
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
