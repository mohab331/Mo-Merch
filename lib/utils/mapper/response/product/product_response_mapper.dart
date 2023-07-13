import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ProductResponseMapper
    implements BaseMapper<ProductResponseModel, ProductResponseEntity> {
  @override
  ProductResponseEntity mapToEntity({required ProductResponseModel? model}) {
    return ProductResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      price: NullReplacements.intReplacement.replaceIfNull(
        model?.price,
      ),
      discount: NullReplacements.intReplacement.replaceIfNull(
        model?.discount,
      ),
      image: NullReplacements.stringReplacement.replaceIfNull(
        model?.image,
      ),
      inCart: model?.inCart,
      images: model?.images,
      description: model?.description,
      inFavorites: model?.inFavorites,
      oldPrice: NullReplacements.intReplacement.replaceIfNull(
        model?.oldPrice,
      ),
    );
  }

  @override
  ProductResponseModel mapToModel({required ProductResponseEntity entity}) {
    return ProductResponseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      discount: entity.discount,
      image: entity.image,
      images: entity.images,
      inCart: entity.inCart,
      inFavorites: entity.inFavorites,
      oldPrice: entity.oldPrice,
      price: entity.price,
    );
  }
}
