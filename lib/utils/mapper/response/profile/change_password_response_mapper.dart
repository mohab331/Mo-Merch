import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ChangePasswordResponseMapper
    implements
        BaseMapper<ChangePasswordResponseModel, ChangePasswordResponseEntity> {
  @override
  ChangePasswordResponseEntity mapToEntity({
    required ChangePasswordResponseModel? model,
  }) {
    return ChangePasswordResponseEntity(
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
    );
  }

  @override
  ChangePasswordResponseModel mapToModel({
    required ChangePasswordResponseEntity entity,
  }) {
    return ChangePasswordResponseModel(
      email: entity.email,
    );
  }
}
