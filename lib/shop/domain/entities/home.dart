import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class HomeResponse{
bool status;
String? message;
HomeData homeData;
HomeResponse({required this.status , required this.message , required this.homeData});
}
class HomeData{
  List<Banners> banners;
  List<Product> products;
  HomeData({required this.banners , required this.products});
}
class Banners{
  int id;
  String image;
  Banners({required this.id , required this.image});
}