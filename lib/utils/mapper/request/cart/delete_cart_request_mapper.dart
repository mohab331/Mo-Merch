import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class DeleteCartItemRequestMapper
    implements
        BaseMapper<DeleteCartItemRequestModel, DeleteCartItemRequestEntity> {
  @override
  DeleteCartItemRequestEntity mapToEntity({
    required DeleteCartItemRequestModel? model,
  }) {
    return DeleteCartItemRequestEntity(
      cartItemId: NullReplacements.intReplacement.replaceIfNull(
        model?.cartItemId,
      ),
    );
  }

  @override
  DeleteCartItemRequestModel mapToModel({
    required DeleteCartItemRequestEntity entity,
  }) {
    return DeleteCartItemRequestModel(cartItemId: entity.cartItemId);
  }
}
