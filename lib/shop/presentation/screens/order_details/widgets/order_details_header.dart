import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({
    required this.orderData,
    super.key,
  });

  final OrderResponseEntity orderData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderInfoSection(
          orderData: orderData,
        ),
        SizedBox(height: 8.h),
        OrderDateAndTotalSection(orderData: orderData),
      ],
    );
  }
}

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({
    required this.orderData,
    super.key,
  });

  final OrderResponseEntity orderData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithSpan(
          mainText: 'Order ',
          spanText: '${orderData.id}',
          mainTextStyle: TextStyle(
            color: R.colors.blackColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
          spanTextStyle: TextStyle(
            color: R.colors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        const Spacer(),
        OrderStatusIndicator(
          orderStatus: orderData.orderStatus,
          orderId: orderData.id,
        ),
      ],
    );
  }
}

class OrderStatusIndicator extends StatelessWidget {
  const OrderStatusIndicator({
    required this.orderStatus,
    required this.orderId,
    super.key,
  });

  final String orderStatus;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    final editOrderState = context.watch<EditOrderCubit>().state;
    final status =
        editOrderState is EditOrderSuccessState ? editOrderState.cancelled : orderStatus;
    return Column(
      children: [
        StatusIndicator(status: status),
        if (status.toLowerCase() == 'new' &&
            editOrderState is! EditOrderSuccessState) ...[
          SizedBox(
            height: 10.h,
          ),
          CancelButton(
            orderID: orderId,
          ),
        ]
      ],
    );
  }
}

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    required this.status,
    super.key,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: _getStatusColor(status),
      child: Text(
        status,
        style: TextStyle(
          color: R.colors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    return status.toLowerCase() == 'new'
        ? R.colors.greenColor
        : R.colors.darkRed;
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({required this.orderID, super.key});
  final int orderID;
  @override
  Widget build(BuildContext context) {
    final editOrderCubit = context.read<EditOrderCubit>();
    final editOrderState = context.watch<EditOrderCubit>().state;
    return GestureDetector(
      onTap: editOrderState is EditOrderLoadingState
          ? null
          : () => editOrderCubit.cancelOrder(
                orderId: orderID,
              ),
      child: CustomContainer(
        color: R.colors.darkRed,
        child: Text(
          'cancel',
          style: TextStyle(
            color: R.colors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({required this.color, required this.child, super.key});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: child,
    );
  }
}

class OrderDateAndTotalSection extends StatelessWidget {
  const OrderDateAndTotalSection({
    required this.orderData,
    super.key,
  });

  final OrderResponseEntity orderData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(orderData.date),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'EGP ${orderData.total.doubleToPrice()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
