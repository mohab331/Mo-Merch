import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

class ToggleFavoriteUsecase
    implements BaseUsecase<Map<String, dynamic>, FavoriteRequestEntity> {
  ToggleFavoriteUsecase({required this.baseFavoriteRepo});

  BaseFavoriteRepo baseFavoriteRepo;

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
      FavoriteRequestEntity favoriteRequestEntity) async {
    return await baseFavoriteRepo.toggleFavorite(
        favoriteRequestEntity: favoriteRequestEntity);
  }
}
