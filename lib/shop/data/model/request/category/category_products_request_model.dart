import 'package:shop_app_clean_architecture/shop/data/model/request/index.dart';

class CategoryProductsRequestModel implements BaseRequestModel {
  const CategoryProductsRequestModel({
    required this.categoryId,
  });

  final int categoryId;

  @override
  Map<String, dynamic> toJson() {
    return {'id':categoryId,};
  }
}
