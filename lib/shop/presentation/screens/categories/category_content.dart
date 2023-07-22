import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/custom_animated_list.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CategoryContent extends HookWidget {
  const CategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final categoryCubit = context.read<CategoryCubit>();
    final categoryState = context.watch<CategoryCubit>().state;
    final isLoading = (categoryState is CategoryLoadingState &&
        categoryCubit.categories.isNotEmpty );
    final categories = (categoryState is CategorySuccessState)
        ? categoryState.categoriesList
        : [];

    return StateHandlingWidget(
      isLoading: (categoryState is CategoryLoadingState && !isLoading),
      hasError: categoryState is CategoryErrorState,
      onRetryButtonPressed: () => _onRetryButtonPressed(categoryCubit),
      successWidget: PaginatedList<CategoryResponseEntity>(
        isLoading: isLoading,
        controller: scrollController,
        onScrollCallBack: _onScroll,
        listEmptyIcon: Icons.category,
        listEmptyTitle: R.strings.emptyCategories,
        onEmptyReloadButtonPressed: () => _onRetryButtonPressed(categoryCubit),
        listChild: CustomAnimatedList(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CategoryItemWidget(
              category: categories[index],
            ),
          ),
          products: categories,
          controller: scrollController,
        ),
        isEmpty: categories.isEmpty,
      ),
    );
  }

  void _onScroll(BuildContext context) {
    final page = context.read<CategoryCubit>().currentPage + 1;
    context.read<CategoryCubit>().getCategories(
          page: page,
        );
  }

  void _onRetryButtonPressed(CategoryCubit categoryCubit) {
    categoryCubit.getCategories(
      page: categoryCubit.currentPage,
    );
  }
}

