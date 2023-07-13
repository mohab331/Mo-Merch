import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CartContent extends StatelessWidget {
  const CartContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      builder: (context, state) {
        final cartState = context.watch<CartCubit>().state;
        final List<CartItem> cartItems =
            (cartState is GetCartSuccessState) ? cartState.cart ?? [] : [];
        return StateHandlingWidget(
          isLoading: cartState is CartLoadingState,
          hasError: cartState is CartErrorState,
          successWidget: cartItems.isEmpty
              ? EmptyWidget(
                  iconData: Icons.add_shopping_cart_outlined,
                  title: R.strings.emptyCart,
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            cartData: cartItems[index],
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                        itemCount: cartItems.length,
                      ),
                    ),
                    const CartStatistics(),
                    SubmitButton(
                      label: R.strings.placeOrder,
                      onButtonPressed: (context) {},
                    ),
                  ],
                ),
        );
      },
      listener: (context, state) {
        Color toastColor = Colors.green;
        if (state.message != null ) {
          toastColor = state is CartErrorState ?R.colors.errorColor :R.colors.successColor;
          R.functions.showToast(message: state.message ?? '', color: toastColor,);
        }
      },
    );
  }
}
