import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetCategoryProductsUsecase implements BaseUsecase<CategoryDetailsResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetCategoryProductsUsecase({required this.baseShopRepository});
  @override
  Future<Either<Failure, CategoryDetailsResponse>> call(GetUseCaseParameters parameters) async{

    return await baseShopRepository.getCategoryDetails(parameters: parameters);
  }
}