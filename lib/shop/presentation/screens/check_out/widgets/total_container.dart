import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class TotalContainer extends StatelessWidget {
  const TotalContainer({
    required this.totalCartPrice,
    required this.totalItems,
    super.key,
  });
  final String totalItems;
  final double totalCartPrice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85.h,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWithSpan(
            mainText: 'Total: ',
            spanText: '$totalCartPrice \$',
          ),
          SizedBox(height: 10.h),
          TextWithSpan(
            mainText: 'Total Items: ',
            spanText: '$totalItems items',
          ),
        ],
      ),
    );
  }
}
