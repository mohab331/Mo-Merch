import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CategoryResponseMapper
    implements BaseMapper<CategoryResponseModel, CategoryResponseEntity> {
  @override
  CategoryResponseEntity mapToEntity({required CategoryResponseModel? model}) {
    return CategoryResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      image: NullReplacements.stringReplacement.replaceIfNull(
        model?.image,
      ),
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
    );
  }

  @override
  CategoryResponseModel mapToModel({required CategoryResponseEntity entity}) {
    return CategoryResponseModel(
      id: entity.id,
      image: entity.image,
      name: entity.name,
    );
  }
}
