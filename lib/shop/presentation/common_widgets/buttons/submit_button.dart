import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class customElevatedButton extends StatelessWidget {
  const customElevatedButton({
    required this.label,
    required this.onButtonPressed,
    this.buttonWidth = double.infinity,
    this.buttonHeight = 40.0,
    this.isLoading = false,
    this.borderRadius,
    this.isEnabled,
    Key? key,
  }) : super(key: key);

  final String label;
  final double buttonWidth;
  final double buttonHeight;
  final bool isLoading;
  final bool? isEnabled;
  final double? borderRadius;
  final Function(BuildContext) onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: Colors.deepOrange,
              size: 50,
            ),
          )
        : SizedBox(
            width: buttonWidth.w,
            height: buttonHeight.h,
            child: ElevatedButton(
              onPressed: isLoading
                  ? () {}
                  : () {
                      FocusScope.of(context).unfocus();
                      onButtonPressed(context);
                    },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      borderRadius?.r ?? 0.0,
                    ),
                  )),
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}
