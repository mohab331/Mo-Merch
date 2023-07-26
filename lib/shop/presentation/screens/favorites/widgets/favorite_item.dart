import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    required this.favoriteProduct,
    required this.onRemoveIconPressed,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity favoriteProduct;
  final void Function() onRemoveIconPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.navigator.navigateToProductDescriptionScreen(
        product: favoriteProduct,
        favoriteCubit: context.read<FavoriteCubit>(),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: 150.h,
        child: Stack(
          children: [
            FavoriteCard(
              favoriteProduct: favoriteProduct,
            ),
            Positioned(
              left: 2.w,
              top: 23.h,
              child: ProductImageCard(
                favoriteProduct: favoriteProduct,
              ),
            ),
            Positioned(
              right: 9,
              child: RemoveIconContainer(
                onRemoveIconTapped: onRemoveIconPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    required this.favoriteProduct,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity favoriteProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.only(
        left: 40.0,
        right: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30.0.r,
        ),
      ),
      elevation: 5,
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 228.w,
          padding: EdgeInsets.symmetric(
            vertical: 20.0.h,
            horizontal: 10.0.w,
          ),
          margin: EdgeInsets.only(
            right: 40.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              30.0.r,
            ),
          ),
          child: SizedBox(
            width: 100.w,
            child: Row(
              children: [
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          favoriteProduct.name,
                          style: TextStyle(
                            color: R.colors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 3,
                        ),
                      ),
                      PriceRowWidget(
                        favoriteProduct: favoriteProduct,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductImageCard extends StatelessWidget {
  const ProductImageCard({
    required this.favoriteProduct,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity favoriteProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0.r,
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: HeroCachedNetworkImage(
        id: favoriteProduct.id,
        imageUrl: favoriteProduct.image,
        imageHeight: 90,
        imageWidth: 110,
        imageFit: BoxFit.fill,
      ),
    );
  }
}

class RemoveIconContainer extends StatelessWidget {
  const RemoveIconContainer({
    this.onRemoveIconTapped,
    super.key,
  });
  final Function()? onRemoveIconTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemoveIconTapped ?? () {},
      child: Container(
        height: 50.h,
        width: 47.w,
        decoration: BoxDecoration(
          color: R.colors.lightRed,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(
              30.r,
            ),
            bottomLeft: Radius.circular(
              37.r,
            ),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const Icon(
          Icons.remove,
        ),
      ),
    );
  }
}

class PriceRowWidget extends StatelessWidget {
  const PriceRowWidget({
    required this.favoriteProduct,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity favoriteProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: R.colors.primaryColor,
              radius: 15.r,
              child: Icon(
                Icons.attach_money,
                color: R.colors.blackColor,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 8.0.w),
          Expanded(
            flex: 3,
            child: Text(
              favoriteProduct.price.doubleToPrice(),
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (favoriteProduct.discount != 0)
            Container(
              margin: EdgeInsets.only(left: 8.0.w),
              padding: EdgeInsets.symmetric(
                horizontal: 8.0.w,
                vertical: 4.0.h,
              ),
              decoration: BoxDecoration(
                color: R.colors.redColor,
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'On Discount!',
                  style: TextStyle(
                    fontSize: 12.0.sp,
                    fontWeight: FontWeight.bold,
                    color: R.colors.whiteColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
