import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class OrderDetailsContent extends StatelessWidget {
  const OrderDetailsContent({required this.orderId, Key? key})
      : super(key: key);
  final int orderId;

  @override
  Widget build(BuildContext context) {
    final orderDetailsCubit = context.read<OrderDetailsCubit>();
    final orderDetailsState = context
        .watch<OrderDetailsCubit>()
        .state;
    return BlocListener<EditOrderCubit, EditOrderState>(
      listener: (context, state) {
        if(state.message != null){
          R.functions.showToast(
            message: state.message ?? '',
            color: state.toastColor ?? R.colors.transparent,
          );
        }
      },
      child: StateHandlingWidget(
        isLoading: orderDetailsState is OrderDetailsLoadingState,
        hasError: orderDetailsState is OrderDetailsErrorState,
        onRetryButtonPressed: () =>
            orderDetailsCubit.getOrderDetails(orderId: orderId),
        successWidget: orderDetailsState is OrderDetailsSuccessState
            ? SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardContainer(
                  child: OrderDetailsHeader(
                    orderData: orderDetailsState.orderDetails.orderData,
                  ),
                ),
                const SizedBox(height: 20),
                CardContainer(
                  child: OrderAddressPaymentDetails(
                    addressData: orderDetailsState.orderDetails.addressData,
                    paymentMethod:
                    orderDetailsState.orderDetails.paymentMethod,
                  ),
                ),
                const SizedBox(height: 20),
                CardContainer(
                  child: OrderProductsWidget(
                    orderProducts:
                    orderDetailsState.orderDetails.orderProducts,
                  ),
                ),
                const SizedBox(height: 20),
                CardContainer(
                  child:
                  OrderSummary(order: orderDetailsState.orderDetails),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
            : Container(),

      ),
    );
  }
}
