import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class BaseResponseMapper<M extends JsonConverter<M>, E>
    implements BaseMapper<BaseResponseModel<M>, BaseResponseEntity<E>> {
  const BaseResponseMapper({
    required this.mapper,
  });
  final BaseMapper<M, E> mapper;
  @override
  BaseResponseEntity<E> mapToEntity({required BaseResponseModel<M>? model}) {
    return BaseResponseEntity<E>(
      entity: mapper.mapToEntity(
        model: model?.model,
      ),
      status: model?.status,
      message: model?.message,
    );
  }

  @override
  BaseResponseModel<M> mapToModel({required BaseResponseEntity<E> entity}) {
    return BaseResponseModel<M>(
      model: mapper.mapToModel(
        entity: entity.entity,
      ),
      message: entity.message,
      status: entity.status,
    );
  }
}
