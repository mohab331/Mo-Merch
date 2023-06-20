import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/product/product_response_model.dart';

import '../../../core/utils/app_strings.dart';
import '../cubit/home/home_cubit.dart';
import '../cubit/home/home_states.dart';
import '../screens/product_description_screen.dart';
import 'animated_favorite_button.dart';

class ProductItemBuilder extends StatelessWidget {
  const ProductItemBuilder({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<HomeCubit>(),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  AppFunctions.navigateTo(
                    context: context,
                    screen: BlocProvider.value(
                      value: HomeCubit.get(context),
                      child: ProductDescriptionScreen(
                        product: product,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Hero(
                          transitionOnUserGestures: true,
                          tag: product.id,
                          child: CachedNetworkImageBuilder(
                            width: context.width,
                            height: context.height * 0.28,
                            imageUrl: product.image,
                          ),
                        ),
                        if (product.discount != 0)
                          Container(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                            ),
                            child: Text(
                              AppStrings.discount,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.ltr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                  ],
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(1)} \$',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.02,
                    ),
                    if (product.discount != 0)
                      Text(
                        product.oldPrice.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                BlocConsumer<HomeCubit, HomeStates>(
                  buildWhen: (previousState, currentState) {
                    return previousState != currentState &&
                            currentState is HomeInstantToggleIsFavoriteState ||
                        currentState is HomeToggleIsFavoriteErrorState &&
                            product.id == product.id;
                  },
                  listener: (context, states) {
                    if (states is HomeToggleIsFavoriteState) {
                      AppFunctions.showToast(
                          message: states.message,
                          color: AppColors.successColor);
                    }
                    if (states is HomeToggleIsFavoriteErrorState) {
                      AppFunctions.showToast(
                          message: states.message, color: AppColors.errorColor);
                    }
                  },
                  builder: (context, states) {
                    return AnimatedFavoriteButton(
                      onButtonPressed: () {
                        HomeCubit.get(context).toggleIsFavorite(
                          context,
                          product: product,
                        );
                      },
                      isFavorite: AppFunctions.getIsFav(context, product.id),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
