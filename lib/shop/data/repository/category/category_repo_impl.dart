import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/data/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CategoryRepoImpl
    with NetworkAndExceptionHandlingMixin
    implements BaseCategoryRepo {
  CategoryRepoImpl({
    required this.baseShopRemoteDS,
    required this.baseListCategoryResponseMapper,
    required this.baseListProductResponseMapper,
    required this.categoryProductRequestMapper,
  });

  final BaseShopRemoteDS baseShopRemoteDS;
  final BaseListResponseMapper<CategoryResponseModel, CategoryResponseEntity>
      baseListCategoryResponseMapper;
  final BaseListResponseMapper<ProductResponseModel, ProductResponseEntity>
      baseListProductResponseMapper;
  final BaseMapper<CategoryProductsRequestModel, CategoryProductsRequestEntity>
      categoryProductRequestMapper;

  /// Retrieves a list of categories.
  ///
  /// Returns a [BaseListResponseEntity] with a list of [CategoryResponseEntity] if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseListResponseEntity<CategoryResponseEntity>>>
      getCategories({required int page,}) async {
    return executeWithNetworkAndExceptionHandling<
        BaseListResponseEntity<CategoryResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getCategories(page: page,);
        return baseListCategoryResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }

  /// Retrieves a list of products for a specific category.
  ///
  /// Returns a [BaseListResponseEntity] with a list of [ProductResponseEntity] if successful,
  /// or a [Failure] if an error occurs.
  @override
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>>
      getCategoryProductsByCategoryId({
    required CategoryProductsRequestEntity categoryProductsRequestEntity,
  }) async {
    return await executeWithNetworkAndExceptionHandling<
        BaseListResponseEntity<ProductResponseEntity>>(
      () async {
        final response = await baseShopRemoteDS.getCategoryProductsById(
          categoryProductsRequestModel: categoryProductRequestMapper.mapToModel(
            entity: categoryProductsRequestEntity,
          ),
        );
        return baseListProductResponseMapper.mapToEntity(
          model: response,
        );
      },
    );
  }
}
