import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class CategoryProductsRequestEntity implements BaseRequestEntity {
  const CategoryProductsRequestEntity({
    required this.categoryId,
    required this.page,
  });

  final int categoryId;
  final int page;

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }
}
