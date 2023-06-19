import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class RegisterRequestMapper
    implements BaseMapper<RegisterRequestModel, RegisterRequestEntity> {
  @override
  RegisterRequestEntity mapToEntity({required RegisterRequestModel? model}) {
    return RegisterRequestEntity(
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      email: NullReplacements.stringReplacement.replaceIfNull(
        model?.email,
      ),
      password: NullReplacements.stringReplacement.replaceIfNull(
        model?.password,
      ),
      phone: NullReplacements.stringReplacement.replaceIfNull(
        model?.phone,
      ),
      image: NullReplacements.stringReplacement.replaceIfNull(
        model?.image,
      ),
    );
  }

  @override
  RegisterRequestModel mapToModel({required RegisterRequestEntity entity}) {
    return RegisterRequestModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      phone: entity.phone,
      image: entity.image,
    );
  }
}
