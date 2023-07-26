import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ToggleFavoriteUsecase
    implements BaseUsecase<BaseResponseEntity<ToggleFavoriteResponseEntity>, FavoriteRequestEntity> {
  ToggleFavoriteUsecase({required this.baseFavoriteRepo});

  BaseFavoriteRepo baseFavoriteRepo;

  @override
  Future<Either<Failure, BaseResponseEntity<ToggleFavoriteResponseEntity>>>
      call(
    FavoriteRequestEntity favoriteRequestEntity,
  ) async {
    return baseFavoriteRepo.toggleFavorite(
      favoriteRequestEntity: favoriteRequestEntity,
    );
  }
}
