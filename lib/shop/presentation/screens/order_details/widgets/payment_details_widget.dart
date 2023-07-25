import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        const Icon(
          Icons.payment,
          size: 25,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
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
              style: const TextStyle(),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}