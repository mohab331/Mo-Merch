import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ChangePasswordRequestMapper
    implements
        BaseMapper<ChangePasswordRequestModel, ChangePasswordRequestEntity> {
  @override
  ChangePasswordRequestEntity mapToEntity({
    required ChangePasswordRequestModel? model,
  }) {
    return ChangePasswordRequestEntity(
      currentPassword: NullReplacements.stringReplacement.replaceIfNull(
        model?.currentPassword,
      ),
      newPassword: NullReplacements.stringReplacement.replaceIfNull(
        model?.newPassword,
      ),
    );
  }

  @override
  ChangePasswordRequestModel mapToModel({
    required ChangePasswordRequestEntity entity,
  }) {
    return ChangePasswordRequestModel(
      currentPassword: entity.currentPassword,
      newPassword: entity.newPassword,
    );
  }
}
