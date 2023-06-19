import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class EmptyResponseModel implements JsonConverter<EmptyResponseModel>{
  const EmptyResponseModel();
  @override
  EmptyResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return this;
  }

}