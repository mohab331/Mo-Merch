import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/buttons/custom_text_button.dart';

class OnBoardingNavigationWidget extends StatelessWidget {
  const OnBoardingNavigationWidget({
    required this.currentListIndex,
    required this.onBoardingEntityListLength,
    required this.onGoPressed,
    required this.onFloatingButtonPressed,
    super.key,
  });
  final int currentListIndex;
  final int onBoardingEntityListLength;
  final Function() onGoPressed;
  final Function() onFloatingButtonPressed;

  @override
  Widget build(BuildContext context) {
    return currentListIndex == (onBoardingEntityListLength - 1)
        ? CustomTextButton(
            label: 'Go',
            onPressed: onGoPressed,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          )
        : FloatingActionButton(
            onPressed: onFloatingButtonPressed,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          );
  }
}
