import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class SearchResponse{
  bool status;
  String? message;
  SearchResponseData searchResponseData;
  SearchResponse({required this.status , required this.message , required this.searchResponseData});
}
class SearchResponseData{
   int currentPage;
   String? nextPageUrl;
   List<Product> searchProducts;
   SearchResponseData({required this.currentPage , required this.nextPageUrl , required this.searchProducts});
}