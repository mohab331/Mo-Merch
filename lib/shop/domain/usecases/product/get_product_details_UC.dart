import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetProductDetailsUc
    implements BaseUsecase<BaseResponseEntity<ProductResponseEntity>, int> {
  GetProductDetailsUc({
    required this.baseProductDetailsRepo,
  });

  BaseProductDetailsRepo baseProductDetailsRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<ProductResponseEntity>>> call(
    int productId,
  ) async {
    return baseProductDetailsRepo.getProductDetails(
      productId: productId,
    );
  }
}
