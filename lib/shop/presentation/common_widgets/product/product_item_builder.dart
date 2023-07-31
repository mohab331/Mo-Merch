import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class ProductItemBuilder extends StatelessWidget {
  const ProductItemBuilder({
    required this.product,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => diInstance.get<FavoriteCubit>(),
      child: Builder(
        builder: (context) {
          return ProductItemCard(
            product: product,
            onTap: () => _onProductTap(
              context,
            ),
          );
        },
      ),
    );
  }

  void _onProductTap(BuildContext context) {
    final favoriteCubit = context.read<FavoriteCubit>();
    context.navigator.navigateToProductDescriptionScreen(
      product: product,
      favoriteCubit: favoriteCubit,
      showToastOnFavoriteToggle: false,
    );
  }
}

class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    required this.product,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final ProductResponseEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shadowColor: R.colors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30.r,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      surfaceTintColor: Colors.red,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProductItemContent(
                product: product,
              ),
              SizedBox(
                height: 20.h,
              ),
              ProductItemFooter(
                product: product,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
