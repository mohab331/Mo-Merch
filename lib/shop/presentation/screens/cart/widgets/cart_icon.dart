import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/cart/cubit/cart_cubit.dart';
import 'package:shop_app_clean_architecture/utils/extensions/index.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          IconButton(
            onPressed: () => context.navigator.navigateToCartScreen(),
            icon: const Icon(
              Icons.shopping_cart,
            ),
          ),
          Container(
            width: 25.w,
            height: 20.h,
            decoration: BoxDecoration(
                color: R.colors.primaryColor,
                borderRadius: BorderRadius.circular(20.r)),
            child: FittedBox(
              child: Text(
                context.watch<CartCubit>().productsInCart.length.toString() ?? '0',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
