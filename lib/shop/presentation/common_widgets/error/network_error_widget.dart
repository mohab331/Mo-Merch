import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    required this.onRetry,
    required this.isLoading,
    super.key,
  });
  final Function() onRetry;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.network_check_rounded,
              size: 80,
              color: Colors.red[900],
            ),
            SizedBox(height: 20.h),
            Text(
              'Network Error',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Oops! Something went wrong. Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.h),
            SubmitButton(
              label: 'Retry',
              onButtonPressed: (context) => onRetry(),
              borderRadius: 15.r,
              isLoading: isLoading,
              buttonWidth: 80,
            ),
          ],
        ),
      ),
    );
  }
}
