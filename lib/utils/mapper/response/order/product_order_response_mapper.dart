import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ProductOrderResponseMapper
    implements
        BaseMapper<ProductOrderResponseModel, ProductOrderResponseEntity> {
  @override
  ProductOrderResponseEntity mapToEntity({
    required ProductOrderResponseModel? model,
  }) {
    return ProductOrderResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      quantity: NullReplacements.intReplacement.replaceIfNull(
        model?.quantity,
      ),
      price: NullReplacements.doubleReplacement.replaceIfNull(
        model?.price,
      ),
      image: NullReplacements.stringReplacement.replaceIfNull(
        model?.image,
      ),
    );
  }

  @override
  ProductOrderResponseModel mapToModel({
    required ProductOrderResponseEntity entity,
  }) {
    return ProductOrderResponseModel(
      id: entity.id,
      image: entity.image,
      name: entity.name,
      price: entity.price,
      quantity: entity.quantity,
    );
  }
}
