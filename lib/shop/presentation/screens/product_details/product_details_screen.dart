import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    required this.product,
    required this.favoriteCubit,
    required this.showToastOnFavoriteToggle,
    Key? key,
  }) : super(key: key);
  static const String routeName = 'ProductDetailsScreen';
  static const String routePath = '/ProductDetailsScreen';

  final ProductResponseEntity product;
  final FavoriteCubit favoriteCubit;
  final bool showToastOnFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => diInstance.get<ProductDetailsCubit>()
            ..getProductDetails(
              productId: product.id,
            ),
        ),
        BlocProvider.value(
          value: favoriteCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 15.sp,
            color: R.colors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 14.w, left: 10.w),
              child: AnimatedProductFavoriteButton(
                showToastOnFavoriteToggle: false,
                product: product,
                iconSize: 25,
              ),
            )
          ],
        ),
        body: ProductDetailsContent(
          product: product,
          showToastOnFavoriteToggle: showToastOnFavoriteToggle,
        ),
      ),
    );
  }
}
