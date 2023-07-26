import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class GetFavoriteUsecase
    implements
        BaseUsecase<BaseListResponseEntity<FavoriteResponseEntity>,
            int> {
  GetFavoriteUsecase({required this.baseFavoriteRepo});

  BaseFavoriteRepo baseFavoriteRepo;

  @override
  Future<Either<Failure, BaseListResponseEntity<FavoriteResponseEntity>>> call(
    int page,
  ) async {
    return baseFavoriteRepo.getFavoriteData(
      page: page,
    );
  }
}
