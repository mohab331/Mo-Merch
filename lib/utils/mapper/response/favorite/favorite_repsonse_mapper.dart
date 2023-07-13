import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class FavoriteResponseMapper
    implements BaseMapper<FavoriteResponseModel, FavoriteResponseEntity> {
  final ProductResponseMapper productResponseMapper = ProductResponseMapper();
  @override
  FavoriteResponseEntity mapToEntity({required FavoriteResponseModel? model}) {
    return FavoriteResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(model?.favoriteItemId),
      product: productResponseMapper.mapToEntity(
        model: model?.productResponseModel,
      ),
    );
  }

  @override
  FavoriteResponseModel mapToModel({required FavoriteResponseEntity entity}) {
    return FavoriteResponseModel(
      favoriteItemId: entity.id,
      productResponseModel: productResponseMapper.mapToModel(
        entity: entity.product,
      ),
    );
  }
}
