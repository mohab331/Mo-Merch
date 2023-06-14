import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ChangePasswordRequestEntity implements BaseRequestEntity {
  const ChangePasswordRequestEntity({
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
