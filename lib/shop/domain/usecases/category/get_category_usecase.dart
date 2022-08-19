import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class GetCategoryUsecase implements BaseUsecase<CategoryResponse ,GetUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  GetCategoryUsecase({required this.baseShopRepository});

  @override
  Future<Either<Failure, CategoryResponse>> call(GetUseCaseParameters parameters) async{
    return await baseShopRepository.getCategoryData(parameters: parameters);
  }
}