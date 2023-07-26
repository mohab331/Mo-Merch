import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ProductDetailsRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseProductDetailsRepo {
  ProductDetailsRepoImpl({
    required this.productResponseMapper,
    required this.baseShopRemoteDS,
  });

  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseResponseMapper<ProductResponseModel, ProductResponseEntity>
      productResponseMapper;
  @override
  Future<Either<Failure, BaseResponseEntity<ProductResponseEntity>>>
      getProductDetails({
    required int productId,
  }) async {
    return executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<ProductResponseEntity>>(() async {
      final response = await baseShopRemoteDS.getProductDetails(
        productId: productId,
      );
      return productResponseMapper.mapToEntity(
        model: response,
      );
    });
  }
}
