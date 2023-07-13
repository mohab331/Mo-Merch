import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetCategoryUsecase
    implements
        BaseUsecase<BaseListResponseEntity<CategoryResponseEntity>,
            int> {
  GetCategoryUsecase({
    required this.baseCategoryRepo,
  });

  BaseCategoryRepo baseCategoryRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<CategoryResponseEntity>>> call(
      int page,) async {
    return  baseCategoryRepo.getCategories(page: page,);
  }
}
