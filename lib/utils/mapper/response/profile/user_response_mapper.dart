import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class UserResponseMapper
    implements BaseMapper<UserResponseModel, UserResponseEntity> {
  @override
  UserResponseEntity mapToEntity({
    required UserResponseModel? model,
  }) {
    return UserResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      credit: NullReplacements.doubleReplacement.replaceIfNull(
        model?.credit,
      ),
      token: NullReplacements.stringReplacement.replaceIfNull(
        model?.token,
      ),
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
      points: NullReplacements.intReplacement.replaceIfNull(
        model?.points,
      ),
      phone: NullReplacements.stringReplacement.replaceIfNull(
        model?.phone,
      ),
    );
  }

  @override
  UserResponseModel mapToModel({
    required UserResponseEntity entity,
  }) {
    return UserResponseModel(
      email: entity.email,
      name: entity.name,
      id: entity.id,
      points: entity.points,
      token: entity.token,
      credit: entity.credit,
      phone: entity.phone,
    );
  }
}
