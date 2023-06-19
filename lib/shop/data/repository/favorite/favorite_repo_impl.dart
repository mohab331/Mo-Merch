import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// Implementation of the `BaseFavoriteRepo` interface.
///
/// This class handles the retrieval of favorite data and toggling the favorite status of items.
class FavoriteRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseFavoriteRepo {
  /// Constructs an instance of `FavoriteRepoImpl` with the required dependencies.
  ///
  /// The [baseShopRemoteDS] is the remote data source for the shop.
  /// The [baseListProductResponseMapper] is the mapper for converting product response models to entities.
  /// The [baseToggleFavoriteResponseMapper] is the mapper for converting toggle favorite response models to entities.
  /// The [favoriteRequestMapper] is the mapper for converting favorite request entities to models.
  FavoriteRepoImpl({
    required this.baseShopRemoteDS,
    required this.baseListProductResponseMapper,
    required this.baseToggleFavoriteResponseMapper,
    required this.favoriteRequestMapper,
  });

  /// The remote data source for the shop.
  final BaseShopRemoteDS baseShopRemoteDS;

  /// Mapper for converting product response models to entities.
  final BaseListResponseMapper<ProductResponseModel, ProductResponseEntity>
      baseListProductResponseMapper;

  /// Mapper for converting toggle favorite response models to entities.
  final BaseResponseMapper<ToggleFavoriteResponseModel,
      ToggleFavoriteResponseEntity> baseToggleFavoriteResponseMapper;

  /// Mapper for converting favorite request entities to models.
  final BaseMapper<FavoriteRequestModel, FavoriteRequestEntity>
      favoriteRequestMapper;

  /// Retrieves the favorite data.
  ///
  /// This method makes a network request to the remote data source to retrieve the favorite data.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseListResponseEntity<ProductResponseEntity>` containing the mapped entity objects on success.
  @override
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>>
      getFavoriteData() async {
    return await executeWithNetworkAndExceptionHandling<
        BaseListResponseEntity<ProductResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getFavoriteData();
        return baseListProductResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Toggles the favorite status of an item.
  ///
  /// This method adds or deletes an item from the favorites based on the given [favoriteRequestEntity].
  /// It makes a network request to the remote data source using the `addOrDeleteFromFavorites` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseResponseEntity<ToggleFavoriteResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseResponseEntity<ToggleFavoriteResponseEntity>>>
      toggleFavorite({
    required FavoriteRequestEntity favoriteRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<ToggleFavoriteResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.addOrDeleteFromFavorites(
          favoriteRequestModel: favoriteRequestMapper.mapToModel(
            entity: favoriteRequestEntity,
          ),
        );
        return baseToggleFavoriteResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
