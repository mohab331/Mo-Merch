import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class HomeResponseMapper
    implements BaseMapper<HomeResponseModel, HomeResponseEntity> {
  ProductResponseMapper productResponseMapper = ProductResponseMapper();
  BannersResponseMapper bannersResponseMapper = BannersResponseMapper();

  @override
  HomeResponseEntity mapToEntity({required HomeResponseModel? model}) {
    return HomeResponseEntity(
      banners: model?.banners
              ?.map((e) => bannersResponseMapper.mapToEntity(model: e))
              .toList() ??
          [],
      products: model?.products
              ?.map((e) => productResponseMapper.mapToEntity(model: e))
              .toList() ??
          [],
    );
  }

  @override
  HomeResponseModel mapToModel({required HomeResponseEntity entity}) {
    return HomeResponseModel(
      banners: entity.banners
          .map((e) => bannersResponseMapper.mapToModel(entity: e))
          .toList(),
      products: entity.products
          .map((e) => productResponseMapper.mapToModel(entity: e))
          .toList(),
    );
  }
}
