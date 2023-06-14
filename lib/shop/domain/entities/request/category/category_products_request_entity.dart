import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class CategoryProductsRequestEntity implements BaseRequestEntity {
  const CategoryProductsRequestEntity({
    required this.categoryId,
  });

  final int categoryId;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
