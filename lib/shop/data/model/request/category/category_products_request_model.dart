import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class CategoryProductsRequestModel implements BaseRequestModel {
  const CategoryProductsRequestModel({
    required this.categoryId,
    required this.page,
  });

  final int categoryId;
  final int page;

  @override
  Map<String, dynamic> toJson() {
    return {'page':page,};
  }
}
