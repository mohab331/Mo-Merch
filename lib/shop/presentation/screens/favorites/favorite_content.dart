import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/favorites/widgets/favorite_item.dart';
import 'package:shop_app_clean_architecture/utils/enums/index.dart';

class FavoriteContent extends HookWidget {
  const FavoriteContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final favoriteCubit = context.read<FavoriteCubit>();
    final appCubit = context.read<AppCubit>();
    final favoriteState = context.watch<FavoriteCubit>().state;
    final favoriteList = appCubit.favoriteProductsMap.values.toList();
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state.message != null) {
          R.functions.showToast(
            message: state.message ?? '',
            color: state.toastColor ?? Colors.white,
          );
        }
      },
      child: StateHandlingWidget(
        isLoading: favoriteState is FavoriteLoadingState &&
            appCubit.favoriteProductsMap.isEmpty,
        hasError: favoriteState is FavoriteErrorState,
        successWidget: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 2),
                child: PaginatedList(
                  isLoading: (favoriteState is FavoriteLoadingState),
                  controller: scrollController,
                  isEmpty: favoriteList.isEmpty,
                  listEmptyIcon: Icons.favorite_outlined,
                  iconColor: Colors.red[900],
                  listEmptyTitle:
                      'No Favorite Item, Start adding your beloved products',
                  onScrollCallBack: _onScroll,
                  listChild: CustomAnimatedList(
                    itemBuilder: (context, index) {
                      final favoriteProduct = favoriteList[index];
                      return FavoriteItem(
                        favoriteProduct: favoriteProduct,
                        onRemoveIconPressed: () => favoriteCubit.toggleFavorite(
                          appCubit,
                          product: favoriteProduct,
                        ),
                      );
                    },
                    products: favoriteList,
                    controller: scrollController,
                    animationType: AnimationEnum.slide,
                  ),
                  loadingWidgetHeight: 100,
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll(BuildContext context) {
    final page = context.read<FavoriteCubit>().currentPage + 1;
    context.read<FavoriteCubit>().getFavoriteData(
          context,
          page: page,
        );
  }
}
