import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SearchResponseEntity
    extends BaseListResponseEntity<ProductResponseEntity> {
  const SearchResponseEntity({
    required super.entityList,
    super.message,
    super.status,
  });
}
