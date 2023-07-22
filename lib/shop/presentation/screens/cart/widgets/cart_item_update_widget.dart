import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CartItemUpdateWidget extends StatelessWidget {
  const CartItemUpdateWidget({required this.cartID, Key? key})
      : super(key: key);
  final int cartID;

  @override
  Widget build(BuildContext context) {
    final cartItem = context.read<CartCubit>().getCartItem(cartID);

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              CustomAvatarButton(
                icon: Icons.add,
                onButtonTap: () => _handleButtonPressed(
                  context,
                  cartItem: cartItem,
                  quantity: 1,
                ),
              ),
              Expanded(
                child: Text(
                  '${cartItem.quantity}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CustomAvatarButton(
                icon: Icons.remove,
                onButtonTap: () => _handleButtonPressed(
                  context,
                  cartItem: cartItem,
                  quantity: -1,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 100.w,
            height: 35.h,
            child: CustomTextButton(
              label: 'Remove',
              onPressed: () => _handleOnDeleteCartPressed(
                context,
                cartItem: cartItem,
              ),
              buttonColor: R.colors.removeColor,
              textColor: Colors.white,
              buttonPadding: const EdgeInsets.all(
                10.0,
              ),
              buttonBorderRadius: BorderRadius.circular(
                20.r,
              ),
              labelFontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _handleButtonPressed(
    BuildContext context, {
    required CartItem cartItem,
    required int quantity,
  }) async {
    await context.read<CartCubit>().updateCart(
          quantity: quantity,
          cartItem: cartItem,
        );
  }

  void _handleOnDeleteCartPressed(
    BuildContext context, {
    required CartItem cartItem,
  }) {
    context.read<CartCubit>().deleteFromCart(
          cartItem: cartItem,
        );
  }
}
