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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                10.0,
              ),
              child: Card(
                elevation: 5,
                child: HeroCachedNetworkImage(
                  id: cartData.id,
                  imageUrl: cartData.product.image,
                  imageHeight: 100,
                  imageWidth: 100,
                  imageFit: BoxFit.contain,
                ),
              ),
            ),
            CartItemInformationWidget(
              cartItem: cartData,
            ),
            SizedBox(
              width: 20.w,
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
