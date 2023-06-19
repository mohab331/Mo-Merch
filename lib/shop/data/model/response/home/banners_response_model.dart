import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class BannersResponseModel implements JsonConverter<BannersResponseModel> {
  const BannersResponseModel({
     this.id,
     this.image,
  });
  final int? id;
  final String? image;

  @override
  BannersResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return BannersResponseModel(
      id: jsonMap?['id'],
      image: jsonMap?['image'],
    );
  }
}
