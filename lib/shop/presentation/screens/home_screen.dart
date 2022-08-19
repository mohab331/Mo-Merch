import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/shop/shop_states.dart';

import '../widgets/product_item_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      buildWhen: (prevState, currentState) {
        return prevState != currentState &&
            (currentState is GetHomeDataLoadingState ||
                currentState is GetHomeDataSuccessState ||
                currentState is GetHomeDataErrorState);
      },
      builder: (context, states) {
        if (states is GetHomeDataLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (states is GetHomeDataErrorState) {
          return NetworkErrorWidget(
              onReloadButtonPressed: (BuildContext context) {
            ShopCubit.get(context).getHomeData(context);
          });
        } else {
          return HomeItem();
        }
      },
    );
  }
}

class HomeItem extends StatelessWidget {
  HomeItem({Key? key}) : super(key: key);
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: ShopCubit.get(context)
                  .banners
                  .map(
                    (e) => CachedNetworkImageBuilder(
                      imageUrl: e.image,
                      width: context.width,
                      height: context.height,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: context.height * 0.3,
                viewportFraction: 1.0,
                clipBehavior: Clip.hardEdge,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                pauseAutoPlayOnTouch: true,
                autoPlay: true,
              ),
              carouselController: _carouselController,
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1 / 2,
              ),
              itemBuilder: (context, index) {
                return ProductItemBuilder(
                  product: ShopCubit.get(context)
                      .homeProductsMap
                      .values
                      .elementAt(index),
                );
              },
              itemCount: ShopCubit.get(context).homeProductsMap.length,
            )
          ],
        ),
      ),
    );
  }
}
