import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/favorite.dart';

class FavoriteResponseModel extends FavoriteResponse {
  FavoriteResponseModel._(
      {required super.status, required super.data, required super.message});
  factory FavoriteResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      FavoriteResponseModel._(
          status: jsonMap['status'],
          data: _FavoriteDataModel.fromJson(jsonMap: jsonMap['data']),
          message: jsonMap['message']);
}

class _FavoriteDataModel extends FavoriteData {
  _FavoriteDataModel._(
      {required super.nextPageUrl,
      required super.currentPage,
      required super.favoriteProducts});
  factory _FavoriteDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _FavoriteDataModel._(
          nextPageUrl: jsonMap['next_page_url'],
          currentPage: jsonMap['current_page'],
          favoriteProducts: (jsonMap['data'] as List).map((e) {
            return ProductModel.fromJson(jsonMap: e['product']);
          }).toList());
}
