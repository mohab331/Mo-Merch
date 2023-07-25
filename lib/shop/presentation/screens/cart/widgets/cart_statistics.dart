import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class CartStatistics extends StatelessWidget {
  const CartStatistics({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final cartTotal = context.watch<CartCubit>().cartTotal.toInt();
    final pay = cartTotal + (cartTotal * 0.14);
    return Container(
      height: 150.h,
      width: double.infinity,
      color: Colors.black12,
      padding: const EdgeInsets.all(
        20.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticsRow(
                  title: '${R.strings.cartTotal} \$',
                  information: cartTotal.formatPrice(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const StatisticsRow(
                  title: 'vat: ',
                  information: '14%',
                ),
                SizedBox(
                  height: 15.h,
                ),
                StatisticsRow(
                  title: 'pay: ',
                  information: '${pay.doubleToPrice()} \$',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticsRow extends StatelessWidget {
  const StatisticsRow(
      {required this.title, required this.information, Key? key})
      : super(key: key);
  final String title;
  final String information;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          information,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
