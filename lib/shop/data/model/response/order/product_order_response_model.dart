import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class ProductOrderResponseModel implements JsonConverter<ProductOrderResponseModel> {

  const ProductOrderResponseModel({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.image,
  });

  final int? id;
  final int? quantity;
  final double? price;
  final String? name;
  final String? image;

  @override
  ProductOrderResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return ProductOrderResponseModel(id: jsonMap?['id'],
      name: jsonMap?['name'],
      quantity: jsonMap?['quantity'],
      price: (jsonMap?['price'] as num).toDouble(),
      image: jsonMap?['image'],
    );
  }
}