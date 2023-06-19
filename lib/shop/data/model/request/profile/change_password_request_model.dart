import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class ChangePasswordRequestModel implements BaseRequestModel {
  const ChangePasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;

  @override
  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
  }
}
