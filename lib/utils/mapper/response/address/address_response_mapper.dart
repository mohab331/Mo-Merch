import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// Represents an address response entity.
class AddressResponseMapper
    implements BaseMapper<AddressResponseModel, AddressResponseEntity> {
  @override
  AddressResponseEntity mapToEntity({required AddressResponseModel? model}) {
    return AddressResponseEntity(
      id: NullReplacements.intReplacement.replaceIfNull(
        model?.id,
      ),
      name: NullReplacements.stringReplacement.replaceIfNull(
        model?.name,
      ),
      city: NullReplacements.stringReplacement.replaceIfNull(
        model?.city,
      ),
      region: NullReplacements.stringReplacement.replaceIfNull(
        model?.region,
      ),
      details: NullReplacements.stringReplacement.replaceIfNull(
        model?.details,
      ),
      notes: NullReplacements.stringReplacement.replaceIfNull(
        model?.notes,
      ),
      longitude: NullReplacements.doubleReplacement.replaceIfNull(
        model?.longitude,
      ),
      latitude: NullReplacements.doubleReplacement.replaceIfNull(
        model?.latitude,
      ),
    );
  }

  @override
  AddressResponseModel mapToModel({required AddressResponseEntity entity}) {
    return AddressResponseModel(
      name: entity.name,
      id: entity.id,
      city: entity.city,
      details: entity.details,
      notes: entity.notes,
      region: entity.region,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }
}
