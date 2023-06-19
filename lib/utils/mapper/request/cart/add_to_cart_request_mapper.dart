import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddToCartRequestMapper
    implements BaseMapper<AddToCartRequestModel, AddToCartRequestEntity> {
  @override
  AddToCartRequestEntity mapToEntity({
    required AddToCartRequestModel? model,
  }) {
    return AddToCartRequestEntity(
      productId: NullReplacements.intReplacement.replaceIfNull(
        model?.productId,
      ),
    );
  }

  @override
  AddToCartRequestModel mapToModel({
    required AddToCartRequestEntity entity,
  }) {
    return AddToCartRequestModel(
      productId: entity.productId,
    );
  }
}
