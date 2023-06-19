import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddOrderRequestMapper
    implements BaseMapper<AddOrderRequestModel, AddOrderRequestEntity> {
  @override
  AddOrderRequestEntity mapToEntity({required AddOrderRequestModel? model}) {
    return AddOrderRequestEntity(
      addressId: NullReplacements.intReplacement.replaceIfNull(
        model?.addressId,
      ),
      paymentMethod: NullReplacements.intReplacement.replaceIfNull(
        model?.paymentMethod,
      ),
    );
  }

  @override
  AddOrderRequestModel mapToModel({required AddOrderRequestEntity entity}) {
    return AddOrderRequestModel(
      addressId: entity.addressId,
      paymentMethod: entity.paymentMethod,
    );
  }
}
