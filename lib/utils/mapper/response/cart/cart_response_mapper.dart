import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/response/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartResponseMapper
    implements BaseMapper<CartResponseModel, CartResponseEntity> {
  CartItemMapper cartItemMapper = CartItemMapper();
  @override
  CartResponseEntity mapToEntity({required CartResponseModel? model}) {
    return CartResponseEntity(
      cartItems: model?.cartItems
              ?.map((e) => cartItemMapper.mapToEntity(model: e))
              .toList() ??
          [],
      totalCost: NullReplacements.doubleReplacement.replaceIfNull(
        model?.totalCost,
      ),
    );
  }

  @override
  CartResponseModel mapToModel({required CartResponseEntity entity}) {
    return CartResponseModel(
      cartItems: entity.cartItems
          .map(
            (e) => cartItemMapper.mapToModel(
              entity: e,
            ),
          )
          .toList(),
      totalCost: entity.totalCost,
    );
  }
}
