import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/loading_widget.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
    required this.isLoading,
    this.showReloadButton = true,
    this.loadingWidgetHeight,
    this.loadingIconSize,
    this.onReloadButtonPressed,
    this.icon,
    this.emptyTitle,
  }) : super(key: key);
  final IconData? icon;
  final String? emptyTitle;
  final Function()? onReloadButtonPressed;
  final bool isLoading;
  final bool showReloadButton;
  final double? loadingIconSize;
  final double? loadingWidgetHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isLoading
          ?  Center(
              child: LoadingWidget(loadingIconSize:loadingIconSize ?? 40 ,loadingHeight:loadingWidgetHeight ,),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.category_outlined,
                  color: R.colors.primaryColor,
                  size: 50,
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  emptyTitle ?? 'No Items Available',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                if (showReloadButton)
                  IconButton(
                    onPressed: onReloadButtonPressed,
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: R.colors.primaryColor,
                      size: 30,
                    ),
                  ),
              ],
            ),
    );
  }
}
