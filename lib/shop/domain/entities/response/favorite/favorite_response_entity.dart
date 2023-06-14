import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class FavoriteResponseEntity
    extends BaseListResponseEntity<ProductResponseEntity> {
  const FavoriteResponseEntity({
    required super.entityList,
  });
}
