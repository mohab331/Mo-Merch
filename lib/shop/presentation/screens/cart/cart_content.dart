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
                emptyWidget: const Icon(Icons.add_shopping_cart),
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
                  CustomElevatedButton(
                    label: R.strings.placeOrder,
                    onButtonPressed: (context) {
                      context.navigator.navigateToCheckOutScreen();
                    },
                  ),
                ],
              ),
      ),
      listener: (context, state) {
        if (state is DeleteCartLoadingState) {
          R.functions.showCupertinoAlertDialog(
            context,
            content: Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: const LoadingWidget(
                loadingIconSize: 40,
              ),
            ),
            title: 'Removing',
            showNoAction: false,
            showOkAction: false,
          );
        } else if (state is DeleteCartSuccessState) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  void _onReloadButtonPressed(CartCubit cartCubit) {
    cartCubit.getCart();
  }
}
