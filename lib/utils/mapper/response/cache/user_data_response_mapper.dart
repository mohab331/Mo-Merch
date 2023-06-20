import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

import 'package:shop_app_clean_architecture/shop/data/index.dart';

class UserDataResponseMapper
    implements BaseMapper<UserDataResponseModel, UserDataResponseEntity> {
  @override
  UserDataResponseEntity mapToEntity({
    required UserDataResponseModel? model,
  }) {
    return UserDataResponseEntity(
      userName: NullReplacements.stringReplacement.replaceIfNull(
        model?.userName,
      ),
      token: NullReplacements.stringReplacement.replaceIfNull(
        model?.token,
      ),
    );
  }

  @override
  UserDataResponseModel mapToModel({
    required UserDataResponseEntity entity,
  }) {
    return UserDataResponseModel(
      userName: entity.userName,
      token: entity.token,
    );
  }
}
