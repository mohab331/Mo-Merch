import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SaveUserDataRequestMapper
    implements BaseMapper<SaveUserDataRequestModel, SaveUserDataRequestEntity> {
  @override
  SaveUserDataRequestEntity mapToEntity({
    required SaveUserDataRequestModel? model,
  }) {
    return SaveUserDataRequestEntity(
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      token: NullReplacements.stringReplacement.replaceIfNull(
        model?.token,
      ),
    );
  }

  @override
  SaveUserDataRequestModel mapToModel({
    required SaveUserDataRequestEntity entity,
  }) {
    return SaveUserDataRequestModel(
      token: entity.token,
      name: entity.name,
    );
  }
}
