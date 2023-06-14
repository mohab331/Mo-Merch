import 'package:shop_app_clean_architecture/shop/data/model/product_model.dart';
import '../../domain/entities/search/search_response_entity.dart';

class SearchResponseModel extends SearchResponse {
  SearchResponseModel._(
      {required super.status,
      required super.message,
      required super.searchResponseData});
  factory SearchResponseModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      SearchResponseModel._(
        status: jsonMap['status'],
        message: jsonMap['message'],
        searchResponseData: _SearchResponseDataModel.fromJson(
          jsonMap: jsonMap['data'],
        ),
      );
}

class _SearchResponseDataModel extends SearchResponseData {
  _SearchResponseDataModel._(
      {required super.currentPage,
      required super.nextPageUrl,
      required super.searchProducts});
  factory _SearchResponseDataModel.fromJson(
          {required Map<String, dynamic> jsonMap}) =>
      _SearchResponseDataModel._(
          currentPage: jsonMap['current_page'],
          nextPageUrl: jsonMap['next_page_url'],
          searchProducts: (jsonMap['data'] as List).map((e) {
            return ProductModel.fromJson(jsonMap: e);
          }).toList());
}
