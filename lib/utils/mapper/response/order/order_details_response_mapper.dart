import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderDetailsResponseMapper
    implements
        BaseMapper<OrderDetailsResponseModel, OrderDetailsResponseEntity> {
  OrderResponseMapper orderResponseMapper = OrderResponseMapper();
  ProductOrderResponseMapper productOrderResponseMapper =
      ProductOrderResponseMapper();
  AddressResponseMapper addressResponseMapper = AddressResponseMapper();
  @override
  OrderDetailsResponseEntity mapToEntity({
    required OrderDetailsResponseModel? model,
  }) {
    return OrderDetailsResponseEntity(
      status: NullReplacements.stringReplacement.replaceIfNull(
        model?.status,
      ),
      orderData: orderResponseMapper.mapToEntity(
        model: model?.orderData,
      ),
      addressData: addressResponseMapper.mapToEntity(
        model: model?.addressData,
      ),
      date: NullReplacements.stringReplacement.replaceIfNull(
        model?.date,
      ),
      promoCode: NullReplacements.stringReplacement.replaceIfNull(
        model?.promoCode,
      ),
      orderProducts: model?.orderProducts
              ?.map(
                (e) => productOrderResponseMapper.mapToEntity(
                  model: e,
                ),
              )
              .toList() ??
          [],
    );
  }

  @override
  OrderDetailsResponseModel mapToModel({
    required OrderDetailsResponseEntity entity,
  }) {
    return OrderDetailsResponseModel(
      status: entity.status,
      addressData: addressResponseMapper.mapToModel(
        entity: entity.addressData,
      ),
      date: entity.date,
      orderData: orderResponseMapper.mapToModel(
        entity: entity.orderData,
      ),
      orderProducts: entity.orderProducts
          .map((e) => productOrderResponseMapper.mapToModel(entity: e))
          .toList(),
      promoCode: entity.promoCode,
    );
  }
}
