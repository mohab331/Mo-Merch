import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCategoryProductsUsecase
    implements
        BaseUsecase<BaseListResponseEntity<ProductResponseEntity>,
            CategoryProductsRequestEntity> {
  GetCategoryProductsUsecase({required this.baseCategoryRepo});

  BaseCategoryRepo baseCategoryRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>> call(
      CategoryProductsRequestEntity categoryProductsRequestEntity) async {
    return await baseCategoryRepo.getCategoryDetails(
      categoryProductsRequestEntity: categoryProductsRequestEntity,
    );
  }
}
