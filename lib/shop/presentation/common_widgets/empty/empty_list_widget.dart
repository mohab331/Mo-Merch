import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    required this.emptyString,
    required this.emptyWidget,
    required this.onReloadButtonPressed,
    required this.isLoading,
    this.iconColor,
    this.iconSize,
    Key? key,
  }) : super(key: key);
  final Widget emptyWidget;
  final double? iconSize;
  final Color? iconColor;
  final String emptyString;
  final Function() onReloadButtonPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: LoadingWidget(
              loadingIconSize: 50,
              loadingHeight: 40,
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emptyWidget,
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  emptyString,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                IconButton(
                  onPressed: onReloadButtonPressed,
                  icon: Icon(Icons.refresh_outlined),
                ),
              ],
            ),
          );
  }
}
