import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.textColor,
    this.buttonColor,
    this.buttonPadding,
    this.buttonBorderRadius,
    this.labelStyle,
    this.labelFontSize,
    Key? key,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? buttonColor;
  final EdgeInsetsGeometry? buttonPadding;
  final BorderRadius? buttonBorderRadius;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: !isEnabled ? null : onPressed,
      style: TextButton.styleFrom(
        padding: buttonPadding ?? EdgeInsets.zero,
        backgroundColor: buttonColor,
        shape: buttonBorderRadius != null
            ? RoundedRectangleBorder(
                borderRadius: buttonBorderRadius!,
              )
            : null,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: labelStyle ??
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: labelFontSize?.sp ?? 16.sp,
                  color: textColor ?? Theme.of(context).primaryColor,
                ),
          ),
        ),
    );
  }
}

