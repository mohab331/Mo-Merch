import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.colors.darkRed,
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Text(
        R.strings.discount,
        style: TextStyle(
          color: R.colors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }
}
