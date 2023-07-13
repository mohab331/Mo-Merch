import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ActionsOnProductWidget extends StatelessWidget {
  const ActionsOnProductWidget({required this.product, Key? key})
      : super(key: key);
  final ProductResponseEntity product;

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    return MultiBlocListener(
      listeners: [
        BlocListener<FavoriteCubit, FavoriteState>(listener: (context, state) {
          if (state.message != null) {
            final toastColors =
                state is FavoriteToggleSuccessState ? Colors.green : Colors.red;
            R.functions.showToast(
              message: state.message ?? '',
              color: toastColors,
            );
          }
        }),
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state.message != null) {
              final toastColor = state is UpdateCartSuccessState ||
                      state is AddToCartSuccessState
                  ? Colors.green
                  : Colors.red;
              R.functions
                  .showToast(message: state.message ?? '', color: toastColor);
            }
          },
          listenWhen: (previousState, currentState) {
            return previousState != currentState &&
                currentState is! CartLoadingState &&
                currentState is! CartInitialState;
          },
        ),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomAddAnimatedButton(
              buttonLabel: cartCubit.isProductInCart(productId: product.id)
                  ? R.strings.removeFromCart
                  : R.strings.addToCart,
              onButtonPressed: () => cartCubit.toggleCart(product),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          AnimatedProductFavoriteButton(
            product: product,
          ),
        ],
      ),
    );
  }
}
