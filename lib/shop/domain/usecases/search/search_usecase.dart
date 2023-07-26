import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SearchUseCase
    implements BaseUsecase<BaseListResponseEntity<ProductResponseEntity>, SearchRequestEntity> {
  SearchUseCase({required this.baseSearchRepo});

  BaseSearchRepo baseSearchRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>> call(
    SearchRequestEntity searchRequestEntity,
  ) async {
    return baseSearchRepo.searchProduct(
      searchRequestEntity: searchRequestEntity,
    );
  }
}
