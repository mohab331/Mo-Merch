import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/loading_data_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/product_description_screen.dart';

import '../../domain/entities/product.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/favorite/favorite_states.dart';
import '../widgets/animated_favorite_button.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentScroll = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;
      if (currentScroll == maxScroll && !_isLoading) {
        Future.delayed(Duration.zero, () {
          _onScroll();
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
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listener: (context, states) {
        if (states is FavoriteLoadingDataState &&
            FavoriteCubit.get(context).favoriteProducts.isNotEmpty &&
            FavoriteCubit.get(context).hasMoreFavoriteData == true) {
          _isLoading = true;
        } else if (states is FavoriteSuccessDataState ||
            states is FavoriteErrorDataState) {
          _isLoading = false;
        } else if (states is FavoriteDeleteItemSuccessState) {
          AppFunctions.showToast(
              message: states.message, color: AppColors.successColor);
        } else if (states is FavoriteErrorDataState) {
          AppFunctions.showToast(
              message: states.errorMessage, color: AppColors.errorColor);
        } else {}
      },
      buildWhen: (previousState, currentState) {
        return previousState != currentState &&
            currentState is! FavoriteDeleteItemSuccessState;
      },
      builder: (context, states) {
        if (states is FavoriteLoadingDataState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (states is FavoriteErrorDataState) {
          return NetworkErrorWidget(
              onReloadButtonPressed: (BuildContext context) {
            FavoriteCubit.get(context).currentFavoritePage = 1;
            FavoriteCubit.get(context).getFavoriteData(context);
          });
        } else if (states is FavoriteSuccessDataState &&
            FavoriteCubit.get(context).favoriteProducts.isEmpty) {
          return const EmptyWidget(
              iconData: Icons.favorite, title: AppStrings.noFavItems);
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (context, index) {
                    return FavoriteProductItem(
                      product: FavoriteCubit.get(context)
                          .favoriteProducts
                          .elementAt(index),
                    );
                  },
                  itemCount: FavoriteCubit.get(context).favoriteProducts.length,
                ),
              ),
              if (_isLoading && states is! FavoriteErrorDataState)
                const LoadingDataWidgetBuilder(),
              if (states is FavoriteErrorDataState &&
                  FavoriteCubit.get(context).favoriteProducts.isNotEmpty)
                NetworkErrorWidget(onReloadButtonPressed: () {
                  FavoriteCubit.get(context).getFavoriteData(context);
                })
            ],
          );
        }
      },
    );
  }

  void _onScroll() {
    FavoriteCubit.get(context).currentFavoritePage += 1;
    FavoriteCubit.get(context).getFavoriteData(
      context,
    );
  }
}

class FavoriteProductItem extends StatelessWidget {
  const FavoriteProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunctions.navigateTo(
          context: context,
          screen: BlocProvider.value(
            value: FavoriteCubit.get(context),
            child: ProductDescriptionScreen(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black, width: 2.0)),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                tag: product.id,
                transitionOnUserGestures: true,
                child: CachedNetworkImageBuilder(
                  width: context.width * 0.15,
                  height: context.height * 0.15,
                  imageUrl: product.image,
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                height: context.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              product.price.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              width: context.width * 0.01,
                            ),
                            if (product.discount != 0)
                              Text(
                                product.oldPrice.toStringAsFixed(1),
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                          ],
                        ),
                        AnimatedFavoriteButton(
                          onButtonPressed: () {
                            FavoriteCubit.get(context).removeFromFavorites(
                              context,
                              product: product,
                            );
                          },
                          isFavorite: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
