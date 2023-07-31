import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    required this.cartData,
    Key? key,
  }) : super(key: key);
  final CartItem cartData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 8.w),
        child: Row(
          children: [
            HeroCachedNetworkImage(
              id: cartData.id,
              imageUrl: cartData.product.image,
              imageHeight: 100,
              imageWidth: 100,
              imageFit: BoxFit.contain,
            ),
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              width: 150.w,
              child: CartItemInformationWidget(
                cartItem: cartData,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            CartItemUpdateWidget(
              cartID: cartData.id,
            ),
          ],
        ),
      ),
    );
  }
}
