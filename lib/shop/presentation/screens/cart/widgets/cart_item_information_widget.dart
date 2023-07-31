import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartItemInformationWidget extends StatelessWidget {
  const CartItemInformationWidget({
    required this.cartItem,
    Key? key,
  }) : super(key: key);
  final CartItem cartItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cartItem.product.name,
          style: TextStyle(
            color: R.colors.blackColor,
          ),
          maxLines: 2,
          textAlign: TextAlign.left,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'EGP ${cartItem.product.price.doubleToPrice()}',
          style: TextStyle(
            color: R.colors.primaryColor,
          ),
        ),
      ],
    );
  }
}
