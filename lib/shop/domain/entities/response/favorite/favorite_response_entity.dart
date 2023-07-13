import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';

class FavoriteResponseEntity{
  const FavoriteResponseEntity({required this.id , required this.product,});
  final int id;
  final ProductResponseEntity product;
}