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
      orderData: orderResponseMapper.mapToEntity(
        model: model?.orderData,
      ),
      addressData: addressResponseMapper.mapToEntity(
        model: model?.addressData,
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

      total: NullReplacements.doubleReplacement.replaceIfNull(
        model?.total,
      ),
      cost: NullReplacements.doubleReplacement.replaceIfNull(
        model?.cost,
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
      addressData: addressResponseMapper.mapToModel(
        entity: entity.addressData,
      ),
      orderData: orderResponseMapper.mapToModel(
        entity: entity.orderData,
      ),
      orderProducts: entity.orderProducts
          .map((e) => productOrderResponseMapper.mapToModel(entity: e))
          .toList(),
      promoCode: entity.promoCode,
      discount: entity.discount,
      cost: entity.cost,
      paymentMethod: entity.paymentMethod,
      total: entity.total,
      vat: entity.vat,
    );
  }
}
