import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class AddAddressRequestMapper
    implements BaseMapper<AddAddressRequestModel, AddAddressRequestEntity> {
  @override
  AddAddressRequestEntity mapToEntity(
      {required AddAddressRequestModel? model}) {
    return AddAddressRequestEntity(
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
      latitude: NullReplacements.doubleReplacement.replaceIfNull(
        model?.latitude,
      ),
      longitude: NullReplacements.doubleReplacement.replaceIfNull(
        model?.longitude,
      ),
    );
  }

  @override
  AddAddressRequestModel mapToModel({required AddAddressRequestEntity entity}) {
    return AddAddressRequestModel(
      name: entity.name,
      city: entity.city,
      region: entity.region,
      details: entity.details,
      notes: entity.notes,
      longitude: entity.longitude,
      latitude: entity.latitude,
    );
  }
}
