import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/category_products/cubit/category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit({
    required this.getCategoryProductsUsecase,
  }) : super(
          CategoryProductsInitialState(),
        );
  final GetCategoryProductsUsecase getCategoryProductsUsecase;
  bool hasNext = true;
  int currentPage = 1;
  List<ProductResponseEntity> productsInCategory = [];

  void getCategoryProductsByID({
    required int page,
    required int categoryId,
  }) async {
    if (!hasNext) {
      return;
    }
    emit(CategoryProductsLoadingState());
    final response = await getCategoryProductsUsecase.call(
      CategoryProductsRequestEntity(
        categoryId: categoryId,
        page: page,
      ),
    );
    response.fold((failure) {
      emit(
        CategoryProductsErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (categoryProductsResponse) {
      currentPage = categoryProductsResponse.currentPage ?? 1;
      hasNext = (categoryProductsResponse.nextPageUrl != null);
      productsInCategory.addAll(categoryProductsResponse.entityList);
      emit(
        CategoryProductsSuccessState(
          productsList: productsInCategory,
        ),
      );
    });
  }
}
