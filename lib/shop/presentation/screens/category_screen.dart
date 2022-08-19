import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/loading_data_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/category.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/widgets/paging_list_view.dart';

import '../cubit/category/category_cubit.dart';
import 'category_products_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _controller = ScrollController();
  int pageNumber = 1;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ShopCubit.get(context).getCategories(context);
    });
    _controller.addListener(
      () {
        double maxScroll = _controller.position.maxScrollExtent;
        double currentScroll = _controller.position.pixels;
        if (currentScroll == maxScroll && !_isLoading) {
          Future.delayed(
            Duration.zero,
            () {
              _onScroll();
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _onRefresh(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, states) {
          if (states is GetCategoryDataLoadingState &&
              ShopCubit.get(context).fetchedCategories.isNotEmpty &&
              ShopCubit.get(context).hasMoreCategories == true) {
            _isLoading = true;
          } else if (states is GetCategoryDataSuccessState ||
              states is GetCategoryDataErrorState) {
            _isLoading = false;
          } else if (states is GetCategoryDataErrorState) {
            AppFunctions.showToast(
              message: states.errorMessage,
              color: AppColors.errorColor,
            );
          } else {}
        },
        buildWhen: (previousState, currentState) {
          return (previousState != currentState) &&
              (currentState is GetCategoryDataSuccessState ||
                  currentState is GetCategoryDataLoadingState ||
                  currentState is GetCategoryDataErrorState);
        },
        builder: (context, states) {
          if (states is GetCategoryDataLoadingState &&
              ShopCubit.get(context).fetchedCategories.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (states is GetCategoryDataErrorState &&
              ShopCubit.get(context).fetchedCategories.isEmpty) {
            return NetworkErrorWidget(
                onReloadButtonPressed: (BuildContext context) {
              _onRefresh();
            });
          } else if (ShopCubit.get(context).fetchedCategories.isEmpty &&
              states is GetCategoryDataSuccessState) {
            return const EmptyWidget(
                iconData: Icons.category, title: AppStrings.emptyCategories);
          } else {
            return Column(
              children: [
                CategoryPagingListView(
                    controller: _controller,
                    list: ShopCubit.get(context).fetchedCategories),
                if (_isLoading &&
                    states is! GetCategoryDataErrorState)
                  const LoadingDataWidgetBuilder(),
                if (states is GetCategoryDataErrorState &&
                    ShopCubit.get(context).fetchedCategories.isNotEmpty)
                  NetworkErrorWidget(
                      onReloadButtonPressed: (BuildContext context) {
                    ShopCubit.get(context).getCategories(context);
                  }),
              ],
            );
          }
        },
      ),
    );
  }

  void _onScroll() {
    ShopCubit.get(context).currentCategoryPage += 1;
    ShopCubit.get(context).getCategories(
      context,
    );
  }
  void _onRefresh() {
    ShopCubit.get(context).currentCategoryPage = 1;
    ShopCubit.get(context).getCategories(context, fromReload: true);
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.categoryData,
  }) : super(key: key);
  final CategoryData categoryData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppFunctions.navigateTo(
          context: context,
          screen: BlocProvider(
            create: (context) => di.sl<CategoryCubit>(),
            child: CategoryProductsScreen(
              categoryId: categoryData.id,
              categoryName: categoryData.name,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImageBuilder(
            imageUrl: categoryData.image,
            width: context.width * 0.4,
            height: context.height * 0.2,
          ),
          SizedBox(
            width: context.width * 0.08,
          ),
          Expanded(
            child: Text(
              categoryData.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
