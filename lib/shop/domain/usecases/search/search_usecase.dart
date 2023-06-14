import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class SearchUseCase
    implements BaseUsecase<SearchResponseEntity, SearchRequestEntity> {
  SearchUseCase({required this.baseSearchRepo});

  BaseSearchRepo baseSearchRepo;

  @override
  Future<Either<Failure, SearchResponseEntity>> call(
    SearchRequestEntity searchRequestEntity,
  ) async {
    return await baseSearchRepo.searchProduct(
      searchRequestEntity: searchRequestEntity,
    );
  }
}
