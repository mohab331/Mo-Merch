import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';

class CategoryResponseModel extends CategoryResponse {
  CategoryResponseModel._(
      {required super.status,
      required super.message,
      required super.categoryResponseData});
  factory CategoryResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      CategoryResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        categoryResponseData: _CategoryResponseDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}
class CategoryDetailsResponseModel extends CategoryDetailsResponse {
  CategoryDetailsResponseModel._(
      {required super.status,
        required super.message,
        required super.categoryDetailsResponseData});
  factory CategoryDetailsResponseModel.fromJson(
      {required Map<String, dynamic> jsonMap}) =>
      CategoryDetailsResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        categoryDetailsResponseData: _CategoryDetailsResponseDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}

class _CategoryResponseDataModel extends CategoryResponseData {
  _CategoryResponseDataModel._(
      {required super.currentPage,
      required super.categories,
      required super.nextPageUrl});
  factory _CategoryResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _CategoryResponseDataModel._(
          currentPage: jsonMap['current_page'],
          categories: (jsonMap['data'] as List).map((e) {
            return _CategoryDataModel.fromJson(jsonMap: e);
          }).toList(),
          nextPageUrl: jsonMap['next_page_url']);
}
class _CategoryDataModel extends CategoryData {
  _CategoryDataModel._(
      {required super.id, required super.image, required super.name});
  factory _CategoryDataModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      _CategoryDataModel._(
          id: jsonMap['id'], image: jsonMap['image'], name: jsonMap['name']);
}
class _CategoryDetailsResponseDataModel extends CategoryDetailsResponseData {
  _CategoryDetailsResponseDataModel._(
      {required super.currentPage,
      required super.nextPageUrl,
      required super.categoryProducts});
  factory _CategoryDetailsResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _CategoryDetailsResponseDataModel._(
          currentPage: jsonMap['current_page'],
          nextPageUrl: jsonMap['next_page_url'],
          categoryProducts: (jsonMap['data'] as List).map((e) {
            return ProductModel.fromJson(jsonMap: e);
          }).toList());
}
