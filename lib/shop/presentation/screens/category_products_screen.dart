import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/loading_data_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/category/category_cubit.dart';

import '../cubit/category/category_states.dart';
import '../widgets/product_item_builder.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);
  final int categoryId;
  final String categoryName;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      CategoryCubit.get(context)
          .getCategoryDetails(context, categoryId: widget.categoryId);
    });
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      if (currentScroll == maxScroll && !_isLoading) {
        Future.delayed(Duration.zero, () {
          _getMoreData();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(() {});
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryName,
          ),
        ),
        body: BlocConsumer<CategoryCubit, CategoryStates>(
          listener: (context, states) {
            if (states is CategoryDetailsSuccessDataState ||
                states is CategoryDetailsErrorDataState) {
              _isLoading = false;
            } else if (states is CategoryDetailsErrorDataState) {
              AppFunctions.showToast(
                  message: states.message, color: AppColors.errorColor);
            } else if (states is CategoryDetailsLoadingDataState &&
                CategoryCubit.get(context).fetchedCategoryProducts.isNotEmpty &&
                CategoryCubit.get(context).hasMoreProductsInCategoryDetails ==
                    true) {
              _isLoading = true;
            } else {}
          },
          buildWhen: (previousState, currentState) {
            return (previousState != currentState) &&
                (currentState is CategoryDetailsLoadingDataState ||
                    currentState is CategoryDetailsErrorDataState ||
                    currentState is CategoryDetailsSuccessDataState ||
                    currentState is CategoryChangeScreen);
          },
          builder: (context, states) {
            if (states is CategoryDetailsLoadingDataState &&
                CategoryCubit.get(context).fetchedCategoryProducts.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (states is CategoryDetailsErrorDataState &&
                CategoryCubit.get(context).fetchedCategoryProducts.isEmpty) {
              return NetworkErrorWidget(
                  onReloadButtonPressed: (BuildContext context) {
                CategoryCubit.get(context).currentCategoryDetailsPage = 1;
                CategoryCubit.get(context)
                    .getCategoryDetails(context, categoryId: widget.categoryId);
              });
            } else if (CategoryCubit.get(context)
                    .fetchedCategoryProducts
                    .isEmpty &&
                states is CategoryDetailsSuccessDataState) {
              return const EmptyWidget(
                  iconData: Icons.category,
                  title: AppStrings.emptyCategoryProducts);
            } else {
              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return ProductItemBuilder(
                          product: CategoryCubit.get(context)
                              .fetchedCategoryProducts[index],
                        );
                      },
                      controller: _scrollController,
                      itemCount: CategoryCubit.get(context)
                          .fetchedCategoryProducts
                          .length,
                    ),
                  ),
                  if (_isLoading && states is! CategoryDetailsErrorDataState)
                    const LoadingDataWidgetBuilder(),
                  if (states is CategoryDetailsErrorDataState &&
                      CategoryCubit.get(context)
                          .fetchedCategoryProducts
                          .isNotEmpty)
                    NetworkErrorWidget(
                      onReloadButtonPressed: (BuildContext context) {
                        CategoryCubit.get(context).getCategoryDetails(context,
                            categoryId: widget.categoryId);
                      },
                    ),
                ],
              );
            }
          },
        ));
  }

  void _getMoreData() {
    CategoryCubit.get(context).currentCategoryDetailsPage += 1;
    CategoryCubit.get(context)
        .getCategoryDetails(context, categoryId: widget.categoryId);
  }
}
