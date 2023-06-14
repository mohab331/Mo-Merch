import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AppThemeRequestEntity implements BaseRequestEntity {
  const AppThemeRequestEntity({required this.isDarkTheme});

  final AppThemeEnum isDarkTheme;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
