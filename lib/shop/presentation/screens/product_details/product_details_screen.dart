import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    required this.product,
    required this.favoriteCubit,
    Key? key,
  }) : super(key: key);
  static const String routeName = 'ProductDetailsScreen';
  static const String routePath = '/ProductDetailsScreen';

  final ProductResponseEntity product;
  final FavoriteCubit favoriteCubit;

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>
          diInstance.get<ProductDetailsCubit>()
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
          ),
          body: ProductDetailsContent(
            product: product,
          ),
        ),
      );
  }
}
