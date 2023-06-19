import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

/// The implementation of the `BaseHomeRepo` interface.
///
/// This class is responsible for retrieving home data from the remote data source.
/// It handles network communication and exception handling.
class HomeRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseHomeRepo {
  /// Constructs a new instance of `HomeRepoImpl`.
  ///
  ///  [BaseShopRemoteDS]: The base remote data source for retrieving home data.
  ///  [BaseResponseMapper]: The response mapper for mapping the home response model to the corresponding entity.
  HomeRepoImpl({
    required this.baseShopRemoteDS,
    required this.baseHomeResponseMapper,
  });
  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseResponseMapper<HomeResponseModel, HomeResponseEntity>
      baseHomeResponseMapper;

  /// Retrieves home data from the remote data source.
  ///
  /// Returns a `Either<Failure, BaseResponseEntity<HomeResponseEntity>>` indicating either a `Failure` or a successful response.
  @override
  Future<Either<Failure, BaseResponseEntity<HomeResponseEntity>>>
      getHomeData() async {
    return await executeWithNetworkAndExceptionHandling<
        BaseResponseEntity<HomeResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getHomeData();
        return baseHomeResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
