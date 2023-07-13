import 'package:flutter/material.dart';
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
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cartItem.product.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Text(
            '${cartItem.product.price.toInt().formatPrice()}\$',
            style: TextStyle(
              color: R.colors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
