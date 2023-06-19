import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class BannersResponseMapper
    implements BaseMapper<BannersResponseModel, BannersResponseEntity> {
  @override
  BannersResponseEntity mapToEntity({required BannersResponseModel? model}) {
    return BannersResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      image: NullReplacements.stringReplacement.replaceIfNull(
        model?.image,
      ),
    );
  }

  @override
  BannersResponseModel mapToModel({required BannersResponseEntity entity}) {
    return BannersResponseModel(
      image: entity.image,
      id: entity.id,
    );
  }
}
