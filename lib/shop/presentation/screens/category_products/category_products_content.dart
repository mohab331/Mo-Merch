import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CategoryProductsContent extends HookWidget {
  const CategoryProductsContent({
    required this.category,
    Key? key,
  }) : super(key: key);
  final CategoryResponseEntity category;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final categoryProductsCubit = context.read<CategoryProductsCubit>();
    final categoryProductsState = context.watch<CategoryProductsCubit>().state;
    final isLoading = (categoryProductsState is CategoryProductsLoadingState &&
        categoryProductsCubit.productsInCategory.isNotEmpty &&
        categoryProductsCubit.hasNext);
    final List<ProductResponseEntity> productsInCategory =
        (categoryProductsState is CategoryProductsSuccessState)
            ? categoryProductsState.productsList
            : [];
    return StateHandlingWidget(
      isLoading:
          (categoryProductsState is CategoryProductsLoadingState && !isLoading),
      hasError: categoryProductsState is CategoryProductsErrorState,
      onRetryButtonPressed: () => _onReloadButtonPressed(
        categoryProductsCubit,
        category.id,
      ),
      successWidget: PaginatedList<ProductResponseEntity>(
        controller: scrollController,
        onEmptyReloadButtonPressed: () =>
            _onReloadButtonPressed(categoryProductsCubit, category.id),
        isEmpty: (productsInCategory.isEmpty),
        isLoading: isLoading,
        listChild: ProductGridView(
          products: productsInCategory,
          controller: scrollController,
          isScrollable: true,
        ),
        listEmptyWidget: Icon(Icons.category_outlined),
        listEmptyTitle: R.strings.emptyCategoryProducts,
        onScrollCallBack: _onScroll,
      ),
    );
  }

  void _onScroll(BuildContext context) {
    final currentPage = context.read<CategoryProductsCubit>().currentPage;
    context.read<CategoryProductsCubit>().getCategoryProductsByID(
        categoryId: category.id, page: (currentPage + 1));
  }

  void _onReloadButtonPressed(
      CategoryProductsCubit categoryProductsCubit, int categoryId) {
    categoryProductsCubit.getCategoryProductsByID(
        page: categoryProductsCubit.currentPage, categoryId: categoryId);
  }
}
