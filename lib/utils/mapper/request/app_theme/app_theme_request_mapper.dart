import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AppThemeRequestMapper
    implements BaseMapper<AppThemeRequestModel, AppThemeRequestEntity> {
  @override
  AppThemeRequestEntity mapToEntity({required AppThemeRequestModel? model}) {
    return AppThemeRequestEntity(
      isDarkTheme: model?.isDarkTheme ?? AppThemeEnum.light,
    );
  }

  @override
  AppThemeRequestModel mapToModel({required AppThemeRequestEntity entity}) {
    return AppThemeRequestModel(
      isDarkTheme: entity.isDarkTheme,
    );
  }
}
