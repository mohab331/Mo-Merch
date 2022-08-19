import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/home.dart';

class HomeResponseModel extends HomeResponse {
  HomeResponseModel._(
      {required super.status, required super.message, required super.homeData});
  factory HomeResponseModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      HomeResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        homeData: _HomeDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}

class _HomeDataModel extends HomeData {
  _HomeDataModel._({required super.banners, required super.products});
  factory _HomeDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _HomeDataModel._(
        banners: (jsonMap['banners'] as List).map((e) {
          return _BannersModel.fromJson(jsonMap: e);
        }).toList(),
        products: (jsonMap['products'] as List).map((e) {
          return ProductModel.fromJson(jsonMap: e);
        }).toList(),
      );
}

class _BannersModel extends Banners {
  _BannersModel({required super.id, required super.image});
  factory _BannersModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _BannersModel(id: jsonMap['id'], image: jsonMap['image']);
}
