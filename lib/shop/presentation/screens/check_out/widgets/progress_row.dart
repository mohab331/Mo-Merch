import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';

class ProgressRow extends StatelessWidget {
  const ProgressRow({required this.selectedContainerIndex, Key? key})
      : super(key: key);
  final int selectedContainerIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0.r),
          bottomRight: Radius.circular(
            30.0.r,
          ),
        ),
        color: R.colors.lightGrey,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 16.0.h,
        horizontal: 10.0.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProgressCircleAvatar(
            value: '1',
            circleAvatarColor: selectedContainerIndex == 0
                ? R.colors.greenColor
                : R.colors.whiteColor,
            textColor: selectedContainerIndex == 0
                ? R.colors.whiteColor
                : R.colors.blackColor,
          ),
          const HorizontalSeparator(),
          ProgressCircleAvatar(
            value: '2',
            circleAvatarColor: selectedContainerIndex == 1
                ? R.colors.greenColor
                : R.colors.whiteColor,
            textColor: selectedContainerIndex == 1
                ? R.colors.whiteColor
                : R.colors.blackColor,
          ),
        ],
      ),
    );
  }
}

class ProgressCircleAvatar extends StatelessWidget {
  const ProgressCircleAvatar({
    required this.value,
    required this.circleAvatarColor,
    required this.textColor,
    Key? key,
  }) : super(key: key);
  final String value;
  final Color circleAvatarColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
      height: 50.h,
      width: 45.w,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(40.0.r,),
        color: circleAvatarColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: 60.w,
      decoration: BoxDecoration(
        color: R.colors.blackColor,
        borderRadius: BorderRadius.circular(
          50.0.r,
        ),
      ),
    );
  }
}
