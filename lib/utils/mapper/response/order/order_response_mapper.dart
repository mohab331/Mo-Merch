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
      points: NullReplacements.intReplacement.replaceIfNull(
        model?.points,
      ),
      total: NullReplacements.doubleReplacement.replaceIfNull(
        model?.total,
      ),
      discount: NullReplacements.doubleReplacement.replaceIfNull(
        model?.discount,
      ),
      paymentMethod: NullReplacements.stringReplacement.replaceIfNull(
        model?.paymentMethod,
      ),
      vat: NullReplacements.doubleReplacement.replaceIfNull(
        model?.vat,
      ),
      products: model?.products
              ?.map(
                (e) => productResponseMapper.mapToEntity(
                  model: e,
                ),
              )
              .toList() ??
          [],
      cost: NullReplacements.doubleReplacement.replaceIfNull(
        model?.cost,
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
      discount: entity.discount,
      cost: entity.cost,
      paymentMethod: entity.paymentMethod,
      points: entity.points,
      products: entity.products
          .map(
            (e) => productResponseMapper.mapToModel(
              entity: e,
            ),
          )
          .toList(),
      vat: entity.vat,
    );
  }
}
