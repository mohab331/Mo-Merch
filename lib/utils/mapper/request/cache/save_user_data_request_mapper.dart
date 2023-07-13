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
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
      phone: NullReplacements.stringReplacement.replaceIfNull(
        model?.phone,
      ),
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
    );
  }

  @override
  SaveUserDataRequestModel mapToModel({
    required SaveUserDataRequestEntity entity,
  }) {
    return SaveUserDataRequestModel(
      name: entity.name,
      token: entity.token,
      id: entity.id,
      phone: entity.phone,
      email: entity.email,
    );
  }
}
