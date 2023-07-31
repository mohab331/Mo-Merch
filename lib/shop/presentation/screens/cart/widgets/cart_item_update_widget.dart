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
    final cartState = context.watch<CartCubit>().state;
    final isUpdateButtonsEnabled =
        !(cartItem.quantity == 1 && cartState is DeleteCartLoadingState);

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAvatarButton(
                icon: Icons.add,
                onButtonTap: () => _handleButtonPressed(
                  context,
                  cartItem: cartItem,
                  quantity: 1,
                ),
                isEnabled: isUpdateButtonsEnabled,
              ),
              Expanded(
                child: Text(
                  '${cartItem.quantity}',
                  style: TextStyle(
                    color: R.colors.blackColor,
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
                isEnabled: isUpdateButtonsEnabled,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 100.w,
            height: 40.h,
            child: CustomTextButton(
              label: 'Remove',
              onPressed: () => _handleOnDeleteCartPressed(
                context,
                cartItem: cartItem,
              ),
              buttonColor: R.colors.redColor,
              textColor: R.colors.whiteColor,
              buttonPadding: const EdgeInsets.all(
                10.0,
              ),
              buttonBorderRadius: BorderRadius.circular(
                20.r,
              ),
              labelFontSize: 14,
              isEnabled: cartState is! DeleteCartLoadingState,
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
