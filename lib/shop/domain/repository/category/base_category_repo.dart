import 'package:dartz/dartz.dart';
import 'package:shop_app_clean_architecture/core/error/failure.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

/// Abstract class that defines the contract for interacting with category-related operations.
abstract class BaseCategoryRepo {
  /// Retrieves the category data.
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [CategoryResponseEntity] representing the category data.
  Future<Either<Failure, BaseListResponseEntity<CategoryResponseEntity>>>
      getCategories();

  /// Retrieves the details of a specific category based on the provided [categoryProductsRequestEntity].
  /// Returns a [Future] of [Either] containing either a [Failure] or a [BaseListResponseEntity] of [ProductResponseEntity] representing the products in the category.
  Future<Either<Failure, BaseListResponseEntity<ProductResponseEntity>>>
  getCategoryProductsByCategoryId({
    required CategoryProductsRequestEntity categoryProductsRequestEntity,
  });
}
