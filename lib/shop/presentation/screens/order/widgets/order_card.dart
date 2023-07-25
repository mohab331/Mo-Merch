import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';

import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    required this.order,
    Key? key,
  }) : super(key: key);
  final OrderResponseEntity order;
  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<EditOrderCubit>();
    final editOrderState = context.watch<EditOrderCubit>().state;
    return GestureDetector(
      onTap: () => context.navigator.navigateToOrderDetailsScreen(
        orderId: order.id,
        editOrderCubit: orderCubit,
      ),
      child: Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0.r,
          ),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithSpan(
                mainText: 'Order ID# ',
                spanText: order.id.toString(),
              ),
              SizedBox(
                height: 15.h,
              ),
              TextWithSpan(
                mainText: 'Order Status: ',
                spanText: editOrderState is EditOrderSuccessState
                    ? editOrderState.cancelled
                    : order.orderStatus,
              ),
              SizedBox(
                height: 15.h,
              ),
              TextWithSpan(
                mainText: 'Order Total: ',
                spanText: order.total.doubleToPrice(),
              ),
              SizedBox(
                height: 15.h,
              ),
              TextWithSpan(
                mainText: 'Order Date: ',
                spanText: order.date,
              ),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
