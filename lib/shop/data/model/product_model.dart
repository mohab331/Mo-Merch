import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel._(
      {
        required super.name,
        required super.id,
      required super.price,
      required super.discount,
      required super.image,
      required super.inCart,
      required super.images,
      required super.description,
      required super.inFavorites,
      required super.oldPrice});
  factory ProductModel.fromJson({required Map<String, dynamic> jsonMap}) =>
      ProductModel._(
          id: jsonMap['id'],
          name: jsonMap['name'],
          price: jsonMap['price'],
          discount: jsonMap['discount'],
          image: jsonMap['image'],
          inCart: jsonMap['in_cart'] ?? false,
          images: jsonMap['images'] != null
              ? (jsonMap['images'] as List).map((e) {
                  return e.toString();
                }).toList()
              : null,
          description: jsonMap['description'],
          inFavorites: jsonMap['in_favorites'],
          oldPrice: jsonMap['old_price']);
}
