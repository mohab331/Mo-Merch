import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class BaseListResponseMapper<M extends JsonConverter<M>, E>
    implements BaseMapper<BaseListResponseModel<M>, BaseListResponseEntity<E>> {
  const BaseListResponseMapper({
    required this.mapper,
  });
  final BaseMapper<M, E> mapper;
  @override
  BaseListResponseEntity<E> mapToEntity({
    required BaseListResponseModel<M>? model,
  }) {
    return BaseListResponseEntity<E>(
      entityList:
          model?.modelList?.map((e) => mapper.mapToEntity(model: e)).toList() ??
              [],
      message: model?.message,
      status: model?.status,
      total: model?.total,
      currentPage: model?.currentPage,
      nextPageUrl: model?.nextPageUrl,
    );
  }

  @override
  BaseListResponseModel<M> mapToModel({
    required BaseListResponseEntity<E> entity,
  }) {
    return BaseListResponseModel<M>(
      modelList:
          entity.entityList.map((e) => mapper.mapToModel(entity: e)).toList(),
      message: entity.message,
      status: entity.status,
      total: entity.total,
      currentPage: entity.currentPage,
      nextPageUrl: entity.nextPageUrl,
    );
  }
}
