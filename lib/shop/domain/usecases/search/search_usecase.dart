import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/search.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_shop_repository.dart';

class SearchUseCase implements BaseUsecase<SearchResponse ,AddUseCaseParameters >{
  BaseShopRepository baseShopRepository;
  SearchUseCase({required this.baseShopRepository});

  @override
  Future<Either<Failure, SearchResponse>> call(AddUseCaseParameters parameters) async{
    return await baseShopRepository.searchProduct(parameters: parameters);

  }
}