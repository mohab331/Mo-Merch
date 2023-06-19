import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderDetailsRequestMapper
    implements BaseMapper<OrderDetailsRequestModel, OrderDetailsRequestEntity> {
  @override
  OrderDetailsRequestEntity mapToEntity(
      {required OrderDetailsRequestModel? model}) {
    return OrderDetailsRequestEntity(
      orderId: NullReplacements.intReplacement.replaceIfNull(
        model?.orderId,
      ),
    );
  }

  @override
  OrderDetailsRequestModel mapToModel(
      {required OrderDetailsRequestEntity entity}) {
    return OrderDetailsRequestModel(
      orderId: entity.orderId,
    );
  }
}
