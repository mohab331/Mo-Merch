import 'package:shop_app_clean_architecture/utils/index.dart';

import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';

class LogoutResponseMapper
    implements BaseMapper<LogoutResponseModel, LogoutResponseEntity> {
  @override
  LogoutResponseEntity mapToEntity({required LogoutResponseModel? model}) {
    return LogoutResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      token: NullReplacements.stringReplacement.replaceIfNull(
        model?.token,
      ),
    );
  }

  @override
  LogoutResponseModel mapToModel({required LogoutResponseEntity entity}) {
    return LogoutResponseModel(
      id: entity.id,
      token: entity.token,
    );
  }
}
