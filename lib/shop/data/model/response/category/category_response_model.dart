import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class CategoryResponseModel implements JsonConverter<CategoryResponseModel> {
  const CategoryResponseModel({
     this.id,
     this.image,
     this.name,
  });

  final int? id;
  final String? name;
  final String? image;

  @override
  CategoryResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return CategoryResponseModel(
      id: jsonMap?['id'],
      image: jsonMap?['image'],
      name: jsonMap?['name'],
    );
  }
}
