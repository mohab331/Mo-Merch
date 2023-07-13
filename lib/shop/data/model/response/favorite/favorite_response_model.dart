import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';

class FavoriteResponseModel implements JsonConverter<FavoriteResponseModel> {
  const FavoriteResponseModel({
     this.favoriteItemId,
     this.productResponseModel,
  });
  final int? favoriteItemId;
  final ProductResponseModel? productResponseModel;
  @override
  FavoriteResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return FavoriteResponseModel(
      favoriteItemId: jsonMap?['id'],
      productResponseModel: const ProductResponseModel().fromJson(
        jsonMap?['product'],
      ),
    );
  }
}
