import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

import 'package:shop_app_clean_architecture/shop/domain/index.dart';

abstract class BaseProductDetailsRepo {
  Future<Either<Failure, BaseResponseEntity<ProductResponseEntity>>>
      getProductDetails({
    required int productId,
  });
}
