import 'package:shop_app_clean_architecture/shop/data/model/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CategoryProductsRequestMapper
    implements
        BaseMapper<CategoryProductsRequestModel,
            CategoryProductsRequestEntity> {
  @override
  CategoryProductsRequestEntity mapToEntity({
    required CategoryProductsRequestModel? model,
  }) {
    return CategoryProductsRequestEntity(
      categoryId: NullReplacements.intReplacement.replaceIfNull(
        model?.categoryId,
      ),
      page: model?.page ?? 1,
    );
  }

  @override
  CategoryProductsRequestModel mapToModel({
    required CategoryProductsRequestEntity entity,
  }) {
    return CategoryProductsRequestModel(
      categoryId: entity.categoryId,
      page: entity.page,
    );
  }
}
