import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartUpdateResponseMapper
    implements BaseMapper<CartUpdateResponseModel, CartUpdateResponseEntity> {
  @override
  CartUpdateResponseEntity mapToEntity(
      {required CartUpdateResponseModel? model}) {
    return CartUpdateResponseEntity(
      total: NullReplacements.doubleReplacement.replaceIfNull(
        model?.total,
      ),
    );
  }

  @override
  CartUpdateResponseModel mapToModel(
      {required CartUpdateResponseEntity entity}) {
    return CartUpdateResponseModel(
      total: entity.total,
    );
  }
}
