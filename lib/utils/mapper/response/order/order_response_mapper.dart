import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderResponseMapper
    implements BaseMapper<OrderResponseModel, OrderResponseEntity> {
  ProductResponseMapper productResponseMapper = ProductResponseMapper();
  @override
  OrderResponseEntity mapToEntity({
    required OrderResponseModel? model,
  }) {
    return OrderResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      date: NullReplacements.stringReplacement.replaceIfNull(
      model?.orderDate,
    ),
      orderStatus: NullReplacements.stringReplacement.replaceIfNull(model?.orderStatus,),
      total: NullReplacements.doubleReplacement.replaceIfNull(
        model?.total,
      ),
    );
  }

  @override
  OrderResponseModel mapToModel({
    required OrderResponseEntity entity,
  }) {
    return OrderResponseModel(
      id: entity.id,
      total: entity.total,
      orderStatus: entity.orderStatus,
      orderDate: entity.date,
    );
  }
}
