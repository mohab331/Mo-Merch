import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class TextWithSpan extends StatelessWidget {
  const TextWithSpan({
    required this.mainText,
    required this.spanText,
    this.mainTextStyle,
    this.spanTextStyle,
    super.key,
  });
  final String mainText;
  final String spanText;
  final TextStyle? mainTextStyle;
  final TextStyle? spanTextStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: mainText,
        style: mainTextStyle ??
            TextStyle(
              color: R.colors.blackColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
        children: [
          TextSpan(
            text: spanText,
            style: spanTextStyle ??
                TextStyle(
                  color: R.colors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
          ),
        ],
      ),
    );
  }
}
