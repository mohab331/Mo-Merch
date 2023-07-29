import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

// PaymentDetails Widget
class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    required this.paymentMethod,
    super.key,
  });
  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.payment,
          size: 25,
          color: R.colors.greyColor,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              R.strings.paymentMethod,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              paymentMethod,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}