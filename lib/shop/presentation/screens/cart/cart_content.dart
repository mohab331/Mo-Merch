import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartContent extends StatelessWidget {
  const CartContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;
    final cartCubit = context.read<CartCubit>();
    final List<CartItem> cartItemsList =
        context.watch<CartCubit>().cartItems.values.toList();

    return BlocListener<CartCubit, CartState>(
      child: StateHandlingWidget(
        isLoading: cartState is CartLoadingState && cartItemsList.isEmpty,
        hasError: cartState is CartErrorState && cartItemsList.isEmpty,
        onRetryButtonPressed: () => _onReloadButtonPressed(cartCubit),
        successWidget: cartItemsList.isEmpty
            ? EmptyListWidget(
                emptyString: R.strings.emptyCart,
                emptyIcon: Icons.add_shopping_cart,
                onReloadButtonPressed: () => _onReloadButtonPressed(cartCubit),
                isLoading: cartState is CartLoadingState,
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartData: cartItemsList[index],
                        );
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartItemsList.length,
                    ),
                  ),
                  const CartStatistics(),
                  SubmitButton(
                    label: R.strings.placeOrder,
                    onButtonPressed: (context) {
                      context.navigator.navigateToCheckOutScreen();
                    },
                  ),
                ],
              ),
      ),
      listener: (context, state) {
        if (state.message != null) {
          R.functions.showToast(
            message: state.message ?? '',
            color: state.toastColor ?? Colors.green,
          );
        }
      },
    );
  }

  void _onReloadButtonPressed(CartCubit cartCubit) {
    cartCubit.getCart();
  }
}
