import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ToggleFavoriteResponseMapper
    implements
        BaseMapper<ToggleFavoriteResponseModel, ToggleFavoriteResponseEntity> {
  @override
  ToggleFavoriteResponseEntity mapToEntity({
    required ToggleFavoriteResponseModel? model,
  }) {
    return ToggleFavoriteResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
    );
  }

  @override
  ToggleFavoriteResponseModel mapToModel({
    required ToggleFavoriteResponseEntity entity,
  }) {
    return ToggleFavoriteResponseModel(
      id: entity.id,
    );
  }
}
