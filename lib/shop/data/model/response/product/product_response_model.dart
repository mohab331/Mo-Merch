import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class ProductResponseModel implements JsonConverter<ProductResponseModel> {
  const ProductResponseModel({
     this.id,
     this.name,
     this.price,
     this.discount,
     this.image,
     this.inCart,
     this.images,
     this.description,
     this.inFavorites,
     this.oldPrice,
  });

  final int? id;
  final String? name;
  final double? price;
  final double? oldPrice;
  final double? discount;
  final String? image;
  final String? description;
  final List<String>? images;
  final bool? inFavorites;
  final bool? inCart;

  @override
  ProductResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return ProductResponseModel(
        id: jsonMap?['id'],
        name: jsonMap?['name'],
        price: jsonMap?['price'],
        discount: jsonMap?['discount'],
        image: jsonMap?['image'],
        inCart: jsonMap?['in_cart'] ?? false,
        images: jsonMap?['images'] != null
            ? (jsonMap?['images'] as List).map((e) {
          return e.toString();
        }).toList()
            : null,
        description: jsonMap?['description'],
        inFavorites: jsonMap?['in_favorites'],
        oldPrice: jsonMap?['old_price']
    );
  }
}
