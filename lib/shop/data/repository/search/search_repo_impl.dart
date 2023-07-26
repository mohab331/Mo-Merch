import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// Implementation of the `BaseSearchRepo` interface.
///
/// This class handles search-related operations, such as searching for products.
class SearchRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseSearchRepo {
  /// Constructs an instance of `SearchRepoImpl` with the required dependencies.
  ///
  /// The [baseShopRemoteDS] is the remote data source for the shop.
  /// The [baseListProductResponseMapper] is the mapper for converting list product response models to entities.
  /// The [searchRequestMapper] is the mapper for converting search request entities to models.
  SearchRepoImpl({
    required this.baseShopRemoteDS,
    required this.baseListProductResponseMapper,
    required this.searchRequestMapper,
  });
  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseListResponseMapper<ProductResponseModel, ProductResponseEntity>
      baseListProductResponseMapper;
  final BaseMapper<SearchRequestModel, SearchRequestEntity> searchRequestMapper;

  /// Searches for products.
  ///
  /// This method sends a search request to the remote data source using the `searchProduct` method.
  ///
  /// Returns a `Future` that resolves to either a `Failure` object indicating an error,
  /// or a `BaseListResponseEntity<ProductResponseEntity>` containing the mapped entity object on success.
  @override
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>>
      searchProduct({
    required SearchRequestEntity searchRequestEntity,
  }) async {
    return executeWithNetworkAndExceptionHandling<
        BaseListResponseEntity<ProductResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.searchProduct(
          searchRequestModel: searchRequestMapper.mapToModel(
            entity: searchRequestEntity,
          ),
        );
        return baseListProductResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
