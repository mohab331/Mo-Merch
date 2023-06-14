import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class HomeResponseEntity {
  const HomeResponseEntity({
    required this.banners,
    required this.products,
  });

  final List<BannersResponseEntity> banners;
  final List<ProductResponseEntity> products;
}
