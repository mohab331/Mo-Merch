import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class FavoriteResponse{
   bool status;
   String? message;
   FavoriteData data;
   FavoriteResponse({required this.status , required this.data , required this.message});

}
class FavoriteData{
  int currentPage;
  String? nextPageUrl;
  List<Product> favoriteProducts;
  FavoriteData({required this.nextPageUrl , required this.currentPage , required this.favoriteProducts});
}