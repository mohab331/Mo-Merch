import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SearchRequestMapper
    implements BaseMapper<SearchRequestModel, SearchRequestEntity> {
  @override
  SearchRequestEntity mapToEntity({required SearchRequestModel? model}) {
    return SearchRequestEntity(
      text: NullReplacements.stringReplacement.replaceIfNull(
        model?.text,
      ),
    );
  }

  @override
  SearchRequestModel mapToModel({required SearchRequestEntity entity}) {
    return SearchRequestModel(
      text: entity.text,
    );
  }
}
