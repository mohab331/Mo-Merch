import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartItemMapper implements BaseMapper<CartItemModel, CartItem> {
  ProductResponseMapper productResponseMapper = ProductResponseMapper();
  @override
  CartItem mapToEntity({required CartItemModel? model}) {
    return CartItem(
      product: productResponseMapper.mapToEntity(
        model: model?.product,
      ),
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      quantity: NullReplacements.intReplacement.replaceIfNull(
        model?.quantity,
      ),
    );
  }

  @override
  CartItemModel mapToModel({required CartItem entity}) {
    return CartItemModel(
      id: entity.id,
      product: productResponseMapper.mapToModel(
        entity: entity.product,
      ),
      quantity: entity.quantity,
    );
  }
}
