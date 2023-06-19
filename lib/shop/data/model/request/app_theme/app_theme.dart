import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AppThemeRequestModel implements BaseRequestModel {
  const AppThemeRequestModel({required this.isDarkTheme});

  final AppThemeEnum isDarkTheme;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
