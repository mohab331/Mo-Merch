import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CheckOutContent extends HookWidget {
  const CheckOutContent({
    required this.cartItems,
    Key? key,
  }) : super(key: key);
  final List<CartItem> cartItems;
  @override
  Widget build(BuildContext context) {
    final checkOutState = context.watch<CheckOutCubit>().state;
    final checkOutCubit = context.read<CheckOutCubit>();
    final index = checkOutState is ToggleBarIndex ? checkOutState.index : 0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProgressRow(
            selectedContainerIndex: index,
          ),
          index == 0
              ? CheckOutDetailsWidget(
                  cartItems: cartItems,
                  onChoseAddressPressed: (address) {
                    checkOutCubit.chosenAddress = address;
                  },
                )
              : CheckOutConfirmationWidget(
                  orderResponseEntity: checkOutCubit.placedOrder,
                ),
        ],
      ),
    );
  }



}
