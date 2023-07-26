import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class UpdateProfileRequestMapper
    implements
        BaseMapper<UpdateProfileRequestModel, UpdateProfileRequestEntity> {
  @override
  UpdateProfileRequestEntity mapToEntity({
    required UpdateProfileRequestModel? model,
  }) {
    return UpdateProfileRequestEntity(
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
      phone: NullReplacements.stringReplacement.replaceIfNull(
        model?.phone,
      ),
    );
  }

  @override
  UpdateProfileRequestModel mapToModel({
    required UpdateProfileRequestEntity entity,
  }) {
    return UpdateProfileRequestModel(
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
    );
  }
}
