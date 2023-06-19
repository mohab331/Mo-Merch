import 'package:shop_app_clean_architecture/shop/data/model/json_converter.dart';
import 'package:shop_app_clean_architecture/shop/data/model/response/index.dart';

class HomeResponseModel implements JsonConverter<HomeResponseModel>{
  const HomeResponseModel({
     this.banners,
     this.products,
  });

  final List<BannersResponseModel>? banners;
  final List<ProductResponseModel>? products;

  @override
  HomeResponseModel fromJson(Map<String, dynamic>? jsonMap) {
    return HomeResponseModel(
      banners: (jsonMap?['banners'] as List?)?.map((e) {
        return const BannersResponseModel().fromJson(e);
      }).toList(),
      products: (jsonMap?['products'] as List?)?.map((e) {
        return const ProductResponseModel().fromJson(e);
      }).toList(),
    );
  }
}
