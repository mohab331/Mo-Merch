import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    required this.order,
    Key? key,
  }) : super(key: key);

  final OrderDetailsResponseEntity order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderRow(
          title: 'Subtotal (${order.orderProducts.length} Item(s) )',
          amount: order.cost.doubleToPrice(),
        ),
        SizedBox(height: 12.h),
        OrderRow(
          title: 'Discount',
          amount: '- EGP ${order.discount.doubleToPrice()}',
        ),
        SizedBox(height: 12.h),
        OrderRow(
          title: R.strings.cartVat,
          amount: 'EGP ${order.vat.doubleToPrice()}',
        ),
        SizedBox(height: 12.h),
        Divider(color: R.colors.greyColor, thickness: 1),
        SizedBox(height: 12.h),
        OrderRow(
          title: 'Amount Paid',
          amount: 'EGP ${order.total.doubleToPrice()}',
        ),
      ],
    );
  }
}

class OrderRow extends StatelessWidget {
  const OrderRow({
    required this.title,
    required this.amount,
    Key? key,
  }) : super(key: key);

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        const Spacer(),
        Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
