import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class FavoriteRequestMapper
    implements BaseMapper<FavoriteRequestModel, FavoriteRequestEntity> {
  @override
  FavoriteRequestEntity mapToEntity({
    required FavoriteRequestModel? model,
  }) {
    return FavoriteRequestEntity(
      productId: NullReplacements.intReplacement.replaceIfNull(
        model?.productId,
      ),
    );
  }

  @override
  FavoriteRequestModel mapToModel({
    required FavoriteRequestEntity entity,
  }) {
    return FavoriteRequestModel(
      productId: entity.productId,
    );
  }
}
