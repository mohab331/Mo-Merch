import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/core/widgets/cached_network_image.dart';
import 'package:shop_app_clean_architecture/core/widgets/empty_widget.dart';
import 'package:shop_app_clean_architecture/core/widgets/network_error_widget.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/cart/cart_response_entity.dart';

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/submit_button.dart';
import '../cubit/cart/cart_cubit.dart';
import '../cubit/cart/cart_states.dart';
import 'check_out_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.appBarCartTitle,
        ),
      ),
      body: BlocConsumer<CartCubit, CartStates>(listener: (context, states) {
        if (states is CartDeleteItemSuccessState) {
          AppFunctions.showToast(
              message: states.message, color: AppColors.successColor);
        } else if (states is CartDeleteItemErrorState) {
          AppFunctions.showToast(
              message: states.message, color: AppColors.errorColor);
        } else if (states is CartUpdateItemErrorState) {
          AppFunctions.showToast(
              message: states.message, color: AppColors.errorColor);
        } else if (states is CartUpdateItemSuccessState) {
          AppFunctions.showToast(
              message: states.message, color: AppColors.successColor);
        } else {}
      }, buildWhen: (previousState, currentState) {
        return previousState != currentState &&
            (currentState is! CartDeleteItemSuccessState &&
                currentState is! CartUpdateItemSuccessState);
      }, builder: (context, states) {
        if (states is CartLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if ((states is CartSuccessDataState ||
                states is CartInstantDeleteItemState) &&
            CartCubit.get(context).cartMap.isEmpty) {
          return const EmptyWidget(
            iconData: Icons.shopping_cart_outlined,
            title: AppStrings.emptyCart,
          );
        } else if (states is CartErrorDataState) {
          return NetworkErrorWidget(
              onReloadButtonPressed: (BuildContext context) {
            CartCubit.get(context).getCartData(context);
          });
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItemBuilder(
                      cartData: CartCubit.get(context).cartMap[
                          CartCubit.get(context)
                              .cartMap
                              .keys
                              .elementAt(index)]!,
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: CartCubit.get(context).cartMap.length,
                ),
              ),
              Container(
                height: context.height * 0.25,
                width: double.infinity,
                color: Colors.black12,
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.cartTotal,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                  CartCubit.get(context)
                                      .cartTotal
                                      .toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.cartVat,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                (CartCubit.get(context).cartVat *
                                        CartCubit.get(context).cartTotal)
                                    .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppStrings.cartItemTotal,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                (CartCubit.get(context).cartSubtotal)
                                    .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          SubmitButton(
                            label: AppStrings.placeOrder,
                            onButtonPressed: (BuildContext context) {
                              AppFunctions.navigateTo(
                                context: context,
                                screen: BlocProvider.value(
                                  value: CartCubit.get(context),
                                  child: const CheckOutScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }
}

class CartItemBuilder extends StatelessWidget {
  const CartItemBuilder({
    Key? key,
    required this.cartData,
  }) : super(key: key);
  final CartData cartData;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Card(
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Hero(
                  tag: cartData.id,
                  child: CachedNetworkImageBuilder(
                    height: context.height * 0.1,
                    imageUrl: cartData.product.image,
                    width: context.width * 0.1,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartData.product.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Text(
                      cartData.product.price.toStringAsFixed(2),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              CartCubit.get(context).updateCart(context,
                                  cartData: cartData, quantity: 1);
                            },
                            child: const CircleAvatar(
                              radius: 13.0,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${cartData.quantity}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black,),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              CartCubit.get(context).updateCart(context,
                                  cartData: cartData, quantity: -1);
                            },
                            child: const CircleAvatar(
                              radius: 13.0,
                              child: Icon(
                                Icons.remove,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        CartCubit.get(context).removeFromCart(
                          context,
                          cartData: cartData,
                        );
                      },
                      child: Text(
                        AppStrings.removeItemFromCart,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.removeColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
