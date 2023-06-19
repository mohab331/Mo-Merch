import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class LoginRequestMapper
    implements BaseMapper<LoginRequestModel, LoginRequestEntity> {
  @override
  LoginRequestEntity mapToEntity({
    required LoginRequestModel? model,
  }) {
    return LoginRequestEntity(
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
      password: NullReplacements.stringReplacement.replaceIfNull(
        model?.password,
      ),
    );
  }

  @override
  LoginRequestModel mapToModel({
    required LoginRequestEntity entity,
  }) {
    return LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }
}
