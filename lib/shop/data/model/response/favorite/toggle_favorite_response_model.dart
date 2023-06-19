import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class ToggleFavoriteResponseModel implements JsonConverter<ToggleFavoriteResponseModel>{
  const ToggleFavoriteResponseModel({this.id,});
  final int? id;
  @override
  ToggleFavoriteResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return ToggleFavoriteResponseModel(id: jsonMap?['id'],);
  }
}