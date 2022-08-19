import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class CategoryResponse{
  bool status;
  String? message;
  CategoryResponseData categoryResponseData;
  CategoryResponse({required this.status, required this.message , required this.categoryResponseData});
}
class CategoryResponseData{
  int currentPage;
  List<CategoryData> categories;
  String? nextPageUrl;
  CategoryResponseData({required this.currentPage , required this.categories , required this.nextPageUrl});
}
class CategoryData{
  int id;
  String name;
  String image;
  CategoryData({required this.id , required this.image , required this.name});
}
class CategoryDetailsResponse{
  bool status;
  String? message;
  CategoryDetailsResponseData categoryDetailsResponseData;
  CategoryDetailsResponse({required this.status,required this.message,required this.categoryDetailsResponseData});
}
class CategoryDetailsResponseData{
  int currentPage;
  String? nextPageUrl;
  List<Product> categoryProducts;
CategoryDetailsResponseData({required this.currentPage , required this.nextPageUrl , required this.categoryProducts});
}