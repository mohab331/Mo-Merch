import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class UpdateCartRequestMapper
    implements BaseMapper<UpdateCartRequestModel, UpdateCartRequestEntity> {
  @override
  UpdateCartRequestEntity mapToEntity({
    required UpdateCartRequestModel? model,
  }) {
    return UpdateCartRequestEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      quantity: NullReplacements.intReplacement.replaceIfNull(
        model?.quantity,
      ),
    );
  }

  @override
  UpdateCartRequestModel mapToModel({
    required UpdateCartRequestEntity entity,
  }) {
    return UpdateCartRequestModel(
      id: entity.id,
      quantity: entity.quantity,
    );
  }
}
